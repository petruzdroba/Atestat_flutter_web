import 'package:flutter/material.dart';

class TextHoverColorSize extends StatefulWidget {
  final String text;
  final double size;
  final Color fromColor;
  final Color toColor;
  final Function _function;

  const TextHoverColorSize(this.text, this.size,this.fromColor, this.toColor,this._function ,{super.key});

  @override
  State<TextHoverColorSize> createState() => _TextHoverColorSizeState();
}

class _TextHoverColorSizeState extends State<TextHoverColorSize> {
  bool didHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget._function();
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
        child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color:!didHover? widget.fromColor:widget.toColor,
              fontSize: !didHover? widget.size:widget.size+3,
              fontWeight: !didHover? FontWeight.normal : FontWeight.bold,
            ),
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.text,
              softWrap: true,
            )
        ),
      ),
    );
  }
}
