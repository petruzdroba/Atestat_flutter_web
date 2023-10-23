import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

class WidgetButtonHover extends StatefulWidget {

  bool didHover = false;

  WidgetButtonHover({super.key});

  @override
  State<WidgetButtonHover> createState() => _WidgetButtonHoverState();
}

class _WidgetButtonHoverState extends State<WidgetButtonHover> {
  get didHover => widget.didHover;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (kDebugMode) {
          print('pressed');
        }
      },
      child: MouseRegion(
        onEnter: (f){
          setState(() {
            widget.didHover= true;
          });
        },
        onExit: (f){
          setState(() {
            widget.didHover= false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: didHover==false? 150:175,
          height: didHover==false? 50: 60,
          decoration: BoxDecoration(
              color: !didHover ? colorOffBlack: colorPureBlack,
              border: Border.all(width: 1.5, color: didHover == false ?colorOffWhite :colorLightPurple),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              tween: Tween<double>(
                begin: didHover ? 16 : 18,
                end: didHover ? 18 : 16,
              ),
              builder: (context, fontSize, child) {
                return Text(
                  'Button Hover',
                  style: TextStyle(
                    color: didHover ? colorLightPurple : colorOffWhite,
                    fontSize: fontSize,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
