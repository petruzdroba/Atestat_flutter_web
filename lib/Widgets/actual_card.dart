import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:google_fonts/google_fonts.dart';

class ActualCard extends StatefulWidget {
  final String text;
  final int size;

  const ActualCard(this.text, this.size, {Key? key}) : super(key: key);

  @override
  State<ActualCard> createState() => _ActualCardState();
}

class _ActualCardState extends State<ActualCard> {
  bool didHover = false;

  Color getRandomColor() {
    final random = Random();
    final List<Color> allowedColors = [
      Colors.red,
      Colors.blue,
      Colors.deepOrange,
      Colors.green,
      Colors.deepPurple
    ];
    return allowedColors[random.nextInt(allowedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: !didHover
              ? (widget.size * 100).toDouble()
              : (widget.size * 100).toDouble() + widget.text.length * 10,
          height: !didHover ? 150 : 175,
        ),
        MouseRegion(
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
            decoration: BoxDecoration(
              color: !didHover ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.primary,
              // Change to white
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: colorGray, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54, // Shadow color
                  offset: Offset(0, 1), // Offset of the shadow
                  blurRadius: 3, // Spread of the shadow
                ),
              ],
            ),
            width: 550,
            height: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 30),
                      child: Column(
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 325),
                            style: GoogleFonts.mukta(
                              fontSize: 30,
                              color:
                                  !didHover ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.background,
                              fontWeight: !didHover ? medium : semiBold,
                              decoration: TextDecoration.none,
                            ),
                            child: Text(widget.text),
                          ),
                          Text(
                            'Book now',
                            style: GoogleFonts.mukta(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: regular,
                                decoration: TextDecoration.none),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 325),
                          width: 70,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30))),
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 335),
                              width: !didHover ? 0 : 70,
                              height: 50,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(Icons.airplanemode_active,
                                    color: !didHover
                                        ? Theme.of(context).colorScheme.background
                                        : Theme.of(context).colorScheme.outline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
