import 'package:flutter/material.dart';

class ImageDisplayList extends StatefulWidget {
  final String link;
  final Function function;

  const ImageDisplayList(
      {super.key, required this.link, required this.function});

  @override
  State<ImageDisplayList> createState() => _ImageDisplayListState();
}

class _ImageDisplayListState extends State<ImageDisplayList> {
  bool didHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (f){
        setState(() {
          didHover = true;
        });
      },
      onExit: (f){
        setState(() {
          didHover = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(5),
          border:Border.all(color:didHover?Theme.of(context).colorScheme.outline :Theme.of(context).colorScheme.onPrimary),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Image.network(
                widget.link,
                width: 50,
                height: 35,
                fit: BoxFit.cover,
              ),
              InkWell(
                  onTap: () {
                    widget.function();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.outline,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
