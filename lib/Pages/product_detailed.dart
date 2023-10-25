import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/ProductDetails.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/icon_hover_action.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Class/MenuOption.dart';
import '../Widgets/navigation_bar.dart';

class ProductDetailed extends StatefulWidget {
  final List<MenuOption> _menuOptions = options;
  final ProductDetails _productDetails;

  ProductDetailed(this._productDetails,{super.key});

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
                                  IconHoverAction(Icons.arrow_back_ios,previous ),
                                  IconHoverAction(Icons.arrow_forward_ios, next,),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: _productDetails.images.length,
                      onDotClicked: (index){
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
                        )
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
  void previous () => _carouselController.previousPage(duration: const Duration(milliseconds: 400));

  void next () => _carouselController.nextPage(duration: const Duration(milliseconds: 400));
}


