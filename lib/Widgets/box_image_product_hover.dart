import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/MenuOption.dart';
import 'package:flutter_club_blaga/Class/Product.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

class BoxImageProductHover extends StatefulWidget {
  final Product product;

  bool didHover = false;

  BoxImageProductHover(this.product, {super.key});

  @override
  State<BoxImageProductHover> createState() => _BoxImageProductHoverState();
}

class _BoxImageProductHoverState extends State<BoxImageProductHover> {
  get didHover => widget.didHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (f) {
        setState(() {
          widget.didHover = true;
        });
      },
      onExit: (f) {
        setState(() {
          widget.didHover = false;
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
            Expanded(
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
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
                        ]
                        )
                    ),
                  child: Row(
                    children: [
                      const Expanded(flex:10,child: SizedBox()),
                      Expanded(flex:!didHover? 4:5,child: Padding(
                        padding:  EdgeInsets.all( !didHover? 15.0: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                color: !didHover ? colorOffWhite: colorLightPurple,
                                fontSize: !didHover ? 18: 20,
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
