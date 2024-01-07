import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/current_username.dart';
import 'Style/assets/fonts/weights.dart';
import 'confirm_action_icon.dart';

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
            color: !didHover
                ? Theme
                .of(context)
                .colorScheme
                .background
                : Theme
                .of(context)
                .colorScheme
                .onPrimary,
            border: Border.all(
                width: !didHover ? 1.0 : 2.0,
                color: didHover == false
                    ? Theme
                    .of(context)
                    .colorScheme
                    .primary
                    : Theme
                    .of(context)
                    .colorScheme
                    .outline),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.fitHeight,
                      ),
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
                          !didHover ? 0.45 : 0.50,
                          1.0
                        ],
                        colors: [
                          !didHover
                              ? Theme
                              .of(context)
                              .colorScheme
                              .background
                              : Theme
                              .of(context)
                              .colorScheme
                              .onPrimary,
                          Colors.transparent
                        ])),
                child: Row(
                  children: [
                    const Expanded(flex: 7, child: SizedBox()),
                    Expanded(
                        flex: !didHover ? 5 : 7,
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
                                style: GoogleFonts.mukta(
                                  color: !didHover
                                      ? Theme
                                      .of(context)
                                      .colorScheme
                                      .primary
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .outline,
                                  fontSize: !didHover ? 20 : 22,
                                  fontWeight: !didHover ? medium : extraBold,
                                  decoration: !didHover
                                      ? TextDecoration.none
                                      : TextDecoration.underline,
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
                                style: GoogleFonts.mukta(
                                  color: !didHover
                                      ? colorGray
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  fontSize: !didHover ? 14 : 15,
                                  height: 1.0,
                                ),
                                child: Text(
                                  didHover
                                      ? '${widget.product.description.substring(
                                      0, min(220,
                                      widget.product.description.length))}(...)'
                                      : '${widget.product.description.substring(
                                      0, min(130,
                                      widget.product.description.length))}(...)',
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 220),
                                style: GoogleFonts.mukta(
                                  color: !didHover
                                      ? Theme
                                      .of(context)
                                      .colorScheme
                                      .outline
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .onSecondary,
                                  fontSize: !didHover ? 18 : 16,
                                  fontWeight: !didHover ? medium : bold,
                                  height: 0.9,
                                ),
                                child: Text(
                                  widget.product.author,
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedDefaultTextStyle(
                                      style: GoogleFonts.mukta(
                                        color: !didHover
                                            ? Theme
                                            .of(context)
                                            .colorScheme
                                            .primary
                                            : Theme
                                            .of(context)
                                            .colorScheme
                                            .outline,
                                        fontSize: !didHover ? 16 : 20,
                                        fontWeight: !didHover ? medium : semiBold,
                                      ),
                                      duration: const Duration(milliseconds: 500),
                                      child: Text('€${widget.product.price}')),
                                  Visibility(
                                    visible: widget.product.author ==
                                        currentUsername.currentusername,
                                    child: ConfirmActionIcon(
                                      icon: Icons.delete,
                                      secondIcon: Icons.delete_forever,
                                      color: Colors.red,
                                      function: () {
                                        setState(() {
                                          print('deleted');
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
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
