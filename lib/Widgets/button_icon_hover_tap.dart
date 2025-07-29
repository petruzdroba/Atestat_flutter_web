import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ButtonIconHoverTap extends StatefulWidget {
  final IconData icon;
  final IconData toIcon;
  final Color colorAfterTap;
  final Function _function;

  const ButtonIconHoverTap(this.icon,this.toIcon,this.colorAfterTap,this._function, {super.key});

  @override
  State<ButtonIconHoverTap> createState() => _ButtonIconHoverTapState();
}

class _ButtonIconHoverTapState extends State<ButtonIconHoverTap> {
  bool didHover = false;
  bool didPress = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          didPress = !didPress;
          if (kDebugMode) {
            print(didPress);
          }
          widget._function();
        });
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
          width: !didHover ? 45 : 50,
          height: !didHover ? 45 : 50,
          decoration: BoxDecoration(
              color: !didHover ? Theme.of(context).colorScheme.background: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(width: 1.5, color: didHover == false ?Theme.of(context).colorScheme.primary :Theme.of(context).colorScheme.outline),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8))),
          child: Icon(!didPress? widget.icon: widget.toIcon, color: !didPress? Theme.of(context).colorScheme.outline: widget.colorAfterTap),
        ),
      ),
    );
  }
}
