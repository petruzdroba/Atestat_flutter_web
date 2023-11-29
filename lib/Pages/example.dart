import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amberAccent,
      child:  Center(
          child: ElevatedButton(onPressed: () {
            currentUsername.currentusername = '3434';
          }, child: const Text('tap'))),
    );
  }
}
