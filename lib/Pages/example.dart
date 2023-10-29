import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amberAccent,
      child: Row(
        children: [
          Text(
            'word',
            style: GoogleFonts.mukta(fontWeight: FontWeight.w900),
          ),
          Text('word'),
        ],
      ),
    );
  }
}
