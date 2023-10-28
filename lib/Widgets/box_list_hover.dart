import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

class BoxListHover extends StatefulWidget {
  final String menuOption;
  final IconData optionIcon;
  final String route;
  final String _currentRoute;

  const BoxListHover(
      this.menuOption, this.optionIcon, this.route, this._currentRoute,
      {super.key});

  @override
  State<BoxListHover> createState() => _BoxListHoverState();
}

class _BoxListHoverState extends State<BoxListHover> {
  bool didHover = false;

  String get menuOption => widget.menuOption;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget._currentRoute == '/error') {
          Beamer.of(context)
              .beamToNamed(widget.route, replaceRouteInformation: true);
        } else {
          Beamer.of(context)
              .popToNamed(widget.route); // Navigate to the desired route
        }
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
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
              color: !didHover ? Colors.transparent : colorLightPurple,
              border: Border.all(
                  width: !didHover ? 0.2 : 0.4,
                  color: !didHover ? colorOffWhite : colorPureBlack)),
          child: Stack(
            children: [
              Visibility(
                visible: widget.route == widget._currentRoute,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: !didHover ? 8 : 10,
                      height: !didHover ? 50 : 60,
                      decoration: BoxDecoration(
                        color: !didHover ? colorLightPurple : colorPureBlack,
                        borderRadius: const BorderRadius.only(topLeft:  Radius.circular(3), bottomLeft: Radius.circular(3))
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: !didHover
                    ? const EdgeInsets.only(top: 15, bottom: 15)
                    : const EdgeInsets.only(top: 17, bottom: 17),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          menuOption,
                          style: TextStyle(
                            fontSize: !didHover ? 16 : 17,
                            fontWeight:
                                !didHover ? FontWeight.normal : FontWeight.bold,
                            color: !didHover ? colorOffWhite : colorOffBlack,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                            visible: didHover,
                            child: Icon(
                              widget.optionIcon,
                              color: colorOffBlack,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
