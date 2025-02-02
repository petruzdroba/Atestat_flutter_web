import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_club_blaga/Class/ProductDetails.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/button_icon_hover_tap.dart';
import 'package:flutter_club_blaga/Widgets/icon_hover_action.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Class/MenuOption.dart';
import '../Widgets/navigation_bar.dart';

class ProductDetailed extends StatefulWidget {
  final List<MenuOption> _menuOptions = options;
  final ProductDetails _productDetails;

  ProductDetailed(this._productDetails, {super.key});

  @override
  State<ProductDetailed> createState() => _ProductDetailedState();
}

class _ProductDetailedState extends State<ProductDetailed> {
  int activeIndex = 0;
  final _carouselController = CarouselController();

  get _productDetails => widget._productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.background,
        child: Row(
          children: [
            SideNavigationBar(widget._menuOptions, '/shop'),
            Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Expanded(
                        flex: 23,
                        child: Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Stack(
                            children: [
                              Center(
                                  child: CarouselSlider.builder(
                                      carouselController: _carouselController,
                                      itemCount: _productDetails.images.length,
                                      itemBuilder: (context, index, realIndex) {
                                        final urlImage =
                                            _productDetails.images[index];
                                        return Image.network(
                                          urlImage,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      options: CarouselOptions(
                                          height: 450,
                                          initialPage: 0,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 10),
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              activeIndex = index;
                                            });
                                          }))),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  IconHoverAction(
                                      Icons.arrow_back_ios, previous),
                                  IconHoverAction(
                                    Icons.arrow_forward_ios,
                                    next,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: _productDetails.images.length,
                      onDotClicked: (index) {
                        _carouselController.animateToPage(index);
                      },
                      effect: ExpandingDotsEffect(
                        dotColor: Theme.of(context).colorScheme.outline,
                        activeDotColor: Theme.of(context).colorScheme.outline,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    Expanded(
                        flex: 30,
                        child: Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 100,
                              right: 100,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          widget._productDetails.name,
                                          softWrap: true,
                                          style: GoogleFonts.mukta(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 60,
                                              fontWeight: bold),
                                        ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'sold by   ',
                                              style: GoogleFonts.mukta(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 23,
                                                fontWeight: light,
                                              ),
                                            ),
                                            TextHoverColorSize(
                                                text: widget
                                                    ._productDetails.author,
                                                size: 35,
                                                fromColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                toColor: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                                function: () {
                                                  Beamer.of(context).beamToNamed(
                                                      '/profile/${widget._productDetails.author}');
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '€${widget._productDetails.price}',
                                        style: GoogleFonts.mukta(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                            fontSize: 30,
                                            fontWeight: semiBold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ButtonIconHoverTap(
                                              Icons.favorite_border,
                                              Icons.favorite,
                                              Colors.red, () async {
                                            if (currentUsername
                                                    .currentusername !=
                                                '-1') {
                                              Response responseList =
                                                  await getFavoriteList(
                                                      currentUsername
                                                          .currentusername);
                                              if (responseList.statusCode ==
                                                  204) {
                                                Response response =
                                                    await addProductToFavorite(
                                                        widget
                                                            ._productDetails.id,
                                                        currentUsername
                                                            .currentusername);
                                                if(response.statusCode != 200){
                                                  setState(() {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor: Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(20)),
                                                        content: Row(
                                                          children: [
                                                            Icon(Icons.check,
                                                                color: Theme.of(context)
                                                                    .colorScheme
                                                                    .background),
                                                            Text(
                                                              'Error while trying to add product to favorites',
                                                              style: TextStyle(
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .background,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                }
                                              } else {
                                                Map<String, dynamic>
                                                    responseBody = jsonDecode(
                                                        responseList.body);

                                                List<int> favorites =
                                                    List<int>.from(responseBody[
                                                        'favorite_list']);

                                                if (favorites.contains(widget
                                                    ._productDetails.id)) {
                                                  Response remove =
                                                      await removeProductFromFavorite(
                                                          widget._productDetails
                                                              .id,
                                                          currentUsername
                                                              .currentusername);
                                                  if(remove.statusCode != 200){
                                                    setState(() {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor: Colors.red,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(20)),
                                                          content: Row(
                                                            children: [
                                                              Icon(Icons.check,
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .background),
                                                              Text(
                                                                'Error while trying to remove product to favorites',
                                                                style: TextStyle(
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .background,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  }
                                                } else {
                                                  Response response =
                                                      await addProductToFavorite(
                                                          widget._productDetails
                                                              .id,
                                                          currentUsername
                                                              .currentusername);
                                                  if(response.statusCode != 200){
                                                    setState(() {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor: Colors.red,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(20)),
                                                          content: Row(
                                                            children: [
                                                              Icon(Icons.check,
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .background),
                                                              Text(
                                                                'Error while trying to add product to favorites',
                                                                style: TextStyle(
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .background,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  }
                                                }
                                              }
                                            }
                                          }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ButtonIconHoverTap(
                                              Icons.shopping_basket,
                                              Icons.check,
                                              Colors.green, () {
                                            if (kDebugMode) {
                                              print('Add');
                                            }
                                          }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ButtonIconHoverTap(
                                              Icons.person_add_alt_1,
                                              Icons.person_add_disabled,
                                              Colors.blue, () {
                                            if (kDebugMode) {
                                              print('Add friend');
                                            }
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, left: 20, right: 20),
                                      child: TextHoverColorSize(
                                          text: widget
                                              ._productDetails.description,
                                          size: 27,
                                          fromColor: colorGray,
                                          toColor: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          function: () {
                                            Clipboard.setData(ClipboardData(
                                                text: widget._productDetails
                                                    .description));
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void previous() => _carouselController.previousPage(
      duration: const Duration(milliseconds: 400));

  void next() =>
      _carouselController.nextPage(duration: const Duration(milliseconds: 400));
}
