import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/PopularProduct.dart';
import 'package:flutter_club_blaga/Pages/error_page.dart';
import 'package:flutter_club_blaga/Pages/product_detailed.dart';
import 'package:flutter_club_blaga/Pages/profile_page.dart';
import 'package:flutter_club_blaga/Service/product_service.dart';
import 'package:flutter_club_blaga/Service/test_service.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/loading_bar_cube.dart';
import 'package:http/http.dart';

import '../Class/Product.dart';
import '../Class/ProductDetails.dart';
import '../Class/user.dart';
import '../Pages/example.dart';
import '../Pages/homepage.dart';
import '../Pages/login_page.dart';
import '../Pages/shop_page.dart';

final routerDelegate = BeamerDelegate(
  initialPath: '/home',
  notFoundPage: const BeamPage(
    key: ValueKey('ErrorPage'),
    title: 'Not found',
    child: ErrorPage('Error - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return BeamPage(
          key: const ValueKey("home_page"),
          title: 'Chief Sosa',
          child: FutureBuilder(
            future: getPopularProduct(),
            builder: (context, AsyncSnapshot<Response> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBarCube(75.0, 1000);
              } else if (snapshot.hasError) {
                return const ErrorPage('Error - Loading not possible!');
              } else {
                final response = snapshot.data;
                if (response?.statusCode == 200) {
                  final jsonResponse = json.decode(response!.body);
                  final popularProduct = PopularProduct.fromJson(jsonResponse);
                  return HomePage(popularProduct);
                } else {
                  return ErrorPage('Error ${response!.statusCode}');
                }
              }
            },
          ),
        );
      },
      '/example': (context, state, data) {
        return BeamPage(
          key: const ValueKey("example"),
          title: 'Example page',
          child: FutureBuilder(
            future: getTestService(),
            builder: (context, AsyncSnapshot<Response> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBarCube(75.0, 1000);
              } else if (snapshot.hasError) {
                return const ErrorPage('Error - Server offline !');
              } else {
                final response = snapshot.data;
                if (response?.statusCode == 200) {
                  final jsonResponse = json.decode(response!.body);
                  String testService = jsonResponse['message'];
                  return ExamplePage(testService);
                } else {
                  return ErrorPage('Error ${response!.statusCode}');
                }
              }
            },
          ),
        );
      },
      '/profile/:username': (context, state, data) {
        var username = state.pathParameters['username'];
        if (username == '-1') {
          return const LogInPage();
          //Here you can add a login and sign up page
        } else if (username!.isNotEmpty) {
          return BeamPage(
            key: ValueKey("profile $username"),
            title: "Profile $username",
            child: FutureBuilder(
                future: getUserbyUsername(username),
                builder: (context, AsyncSnapshot<Response> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingBarCube(75.0, 1000);
                  } else if (snapshot.hasError) {
                    return const ErrorPage('Error - Loading user!');
                  } else {
                    final response = snapshot.data;
                    if (response?.statusCode == 200) {
                      final jsonResponse = json.decode(response!.body);
                      final user = User.fromJson(jsonResponse);
                      return ProfilePage(user: user);
                    } else {
                      return ErrorPage('Error ${response!.statusCode}');
                    }
                  }
                }),
          );
        }
      },
      '/shop': (context, state, data) {
        return BeamPage(
          key: const ValueKey("shop"),
          title: 'Shop Page',
          child: FutureBuilder(
            future: getProductList(),
            builder: (context, AsyncSnapshot<Response> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBarCube(75.0, 1000);
              } else if (snapshot.hasError) {
                return const ErrorPage('Error - Loading not possible!');
              } else {
                final response = snapshot.data;
                List<Product> products = (jsonDecode(response!.body) as List)
                    .map((e) => Product.fromJson(e))
                    .toList();
                if (products.isEmpty) {
                  // Handle the case where the list is empty
                  return const ErrorPage('Error - No products available!');
                }else{
                  return ShopPage(products);
                }
              }
            },
          ),
        );
      },
      '/shop/:product': (context, state, data) {
        var product = state.pathParameters['product'];
        RegExp numericRegExp = RegExp(r'^\d+$');
        if (product!.contains('product') &&
            numericRegExp.hasMatch(product.replaceFirst('product', ''))) {
          product = product.replaceFirst('product', '');
          return BeamPage(
            key: ValueKey('product$product'),
            title: 'product$product',
            child: Builder(
              builder: (context) {
                return FutureBuilder<Response>(
                  future: getProductDetails(int.parse(product!)),
                  builder: (context, AsyncSnapshot<Response> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingBarCube(75.0, 1000);
                    } else if (snapshot.hasError) {
                      return const ErrorPage('Error - Loading not possible!');
                    } else {
                      final response = snapshot.data;
                      if (response?.statusCode == 200) {
                        final jsonResponse = json.decode(response!.body);
                        final product = ProductDetails.fromJson(jsonResponse);
                        return ProductDetailed(product);
                      } else if (response?.statusCode == 404) {
                        return const ErrorPage(
                            'Error - product not available!');
                      } else {
                        return ErrorPage('Error ${response!.statusCode}');
                      }
                    }
                  },
                );
              },
            ),
          );
        } else {
          return const BeamPage(
            key: ValueKey('ErrorPage'),
            title: 'Error',
            child: ErrorPage('Error - product not available!'),
          );
        }
      },
      '/sell': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sell_page'),
          title: 'Sell item',
          child: Placeholder(),
        );
      },
    },
  ),
);
