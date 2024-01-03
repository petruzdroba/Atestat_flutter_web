import 'package:flutter/material.dart';

class SmallOptionBoxMenu extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;
  final Function function;
  const SmallOptionBoxMenu({super.key, required this.name, required this.icon, required this.color, required this.function});

  @override
  State<SmallOptionBoxMenu> createState() => _SmallOptionBoxMenuState();
}

class _SmallOptionBoxMenuState extends State<SmallOptionBoxMenu> {
  bool didHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          widget.function();
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
        child: Container(
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
            border:Border.all(color:didHover? widget.color :Theme.of(context).colorScheme.onPrimary),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:!didHover? 14:20, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  Icon(widget.icon, color: widget.color,),
                  Text(widget.name, style: TextStyle(color: widget.color, fontSize: 18),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
