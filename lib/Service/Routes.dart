import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Pages/error_page.dart';
import 'package:flutter_club_blaga/Pages/product_detailed.dart';
import 'package:flutter_club_blaga/Service/product_service.dart';
import 'package:flutter_club_blaga/Widgets/loading_bar_cube.dart';
import 'package:http/http.dart';

import '../Class/Product.dart';
import '../Pages/example.dart';
import '../Pages/homepage.dart';
import '../Pages/shop_page.dart';

final routerDelegate = BeamerDelegate(
  initialPath: '/home',
  notFoundPage: BeamPage(
    key: const ValueKey('ErrorPage'),
    title: 'Not found',
    child: ErrorPage(),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return BeamPage(
          key: const ValueKey("home_page"),
          title: 'Chief Sosa',
          child: HomePage(),
        );
      }, //sunt fullstack acum
      '/example': (context, state, data) {
        return const BeamPage(
          key: ValueKey("example"),
          title: 'Zdroba bss',
          child: ExamplePage(),
        );
      },
      '/shop': (context, state, data) {
        return BeamPage(
          key: const ValueKey("shop"),
          title: 'Shop Page',
          child: FutureBuilder(
            future: getProductList(),
            builder: (context, AsyncSnapshot<Response> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBarCube();
              } else if (snapshot.hasError) {
                return ErrorPage();
              } else {
                final response = snapshot.data;
                List<Product> products = (jsonDecode(response!.body) as List)
                    .map((e) => Product.fromJson(e))
                    .toList();
                return ShopPage(products);
              }
            },
          ),
        );
      },
      '/shop/:product':(context, state, data){
        final product = state.pathParameters['product'];
        if(product!.contains('product'))
          {
            return BeamPage(
              key: ValueKey('Shop-$product'),
              title: 'Shop - $product',
              popToNamed: '/shop',
              child: ProductDetailed(),
            );
          }
        else {
          return BeamPage(
            key: const ValueKey('ErrorPage'),
            title: 'Error',
            child: ErrorPage(),
          );
        }
      },
    },
  ),
);