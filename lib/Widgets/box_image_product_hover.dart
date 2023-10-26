import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

class BoxImageProductHover extends StatefulWidget {
  final Product product;

  const BoxImageProductHover(this.product, {super.key});

  @override
  State<BoxImageProductHover> createState() => _BoxImageProductHoverState();
}

class _BoxImageProductHoverState extends State<BoxImageProductHover> {
  bool didHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Beamer.of(context)
            .popToNamed('/shop/product${widget.product.id.toString()}');
      },
      child: MouseRegion(
        onEnter: (f) {
          setState(() {
            didHover = true;
          });
        },
        onExit: (f) {
          setState(() {
            didHover = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: !didHover ? 500 : 525,
          height: !didHover ? 250 : 275,
          decoration: BoxDecoration(
            color: !didHover ? colorOffBlack : colorPureBlack,
            border: Border.all(
                width: !didHover ? 1.0 : 2.0,
                color: didHover == false ? colorOffWhite : colorLightPurple),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        stops: [
                      !didHover ? 0.40 : 0.55,
                      1.0
                    ],
                        colors: [
                      !didHover ? colorOffBlack : colorPureBlack,
                      Colors.transparent
                    ])),
                child: Row(
                  children: [
                    const Expanded(flex: 7, child: SizedBox()),
                    Expanded(
                        flex: !didHover ? 4 : 7,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: !didHover ? 15.0 : 20.0,
                              bottom: !didHover ? 15.0 : 20.0,
                              right: !didHover ? 15.0 : 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 220),
                                style: TextStyle(
                                  color: !didHover
                                      ? colorOffWhite
                                      : colorLightPurple,
                                  fontSize: !didHover ? 18 : 20,
                                  fontWeight: !didHover
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                                child: Text(
                                  widget.product.name,
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 220),
                                style: TextStyle(
                                  color: !didHover ? colorGray : colorOffWhite,
                                  fontSize: !didHover ? 12 : 14,
                                ),
                                child: Text(
                                  !didHover
                                      ? '${widget.product.description.substring(0, 75)}(...)'
                                      : widget.product.description,
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 220),
                                style: TextStyle(
                                  color: !didHover
                                      ? colorLightPurple
                                      : colorPureWhite,
                                  fontSize: !didHover ? 14 : 12,
                                  fontWeight: !didHover
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                                child: Text(
                                  '${widget.product.list.first} vs. ${widget.product.list.last}',
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedDefaultTextStyle(
                                  style: TextStyle(
                                    color: !didHover
                                        ? colorOffWhite
                                        : colorLightPurple,
                                    fontSize: !didHover ? 14 : 16,
                                    fontWeight: !didHover
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text('€${widget.product.price}'))
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
