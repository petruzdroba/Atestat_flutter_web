import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_club_blaga/Class/ProductDetails.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/button_icon_hover_tap.dart';
import 'package:flutter_club_blaga/Widgets/icon_hover_action.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color_size.dart';
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
        color: colorOffBlack,
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
                          color: colorOffBlack,
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
                        dotColor: colorLightPurple,
                        activeDotColor: colorLightPurple,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    Expanded(
                        flex: 30,
                        child: Container(
                          color: colorOffBlack,
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
                                          style: TextStyle(
                                              color: colorOffWhite,
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold),
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
                                              style: TextStyle(
                                                color: colorOffWhite,
                                                fontSize: 23,
                                              ),
                                            ),
                                            TextHoverColorSize(
                                                widget._productDetails.author,
                                                35,
                                                colorOffWhite,
                                                colorLightPurple,
                                                () {} //Add later profile opening to seller profile
                                                ),
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
                                        style: TextStyle(
                                            color: colorLightPurple,
                                            fontSize: 30,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ButtonIconHoverTap(
                                              Icons.favorite_border,
                                              Icons.favorite,
                                              Colors.red, () {
                                            if (kDebugMode) {
                                              print('Like');
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
                                          widget._productDetails.description,
                                          27,
                                          colorGray,
                                          colorPureWhite, () {
                                        Clipboard.setData(ClipboardData(
                                            text: widget
                                                ._productDetails.description));
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
