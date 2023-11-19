import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/actual_card.dart';

class StackOfCards extends StatefulWidget {
  const StackOfCards({super.key});

  @override
  StackOfCardsState createState() => StackOfCardsState();
}

class StackOfCardsState extends State<StackOfCards> {
  final List<String> list = ['Austria', 'Germany', 'Singapore', 'Holland', 'Mexico', 'Portugal'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: list.asMap().entries.toList().reversed.map((entry) {
        int index = entry.key;
        String text = entry.value;
        // print(text+text.length.toString());
        return ActualCard(text, index);
      }).toList(),
    );
  }
}
