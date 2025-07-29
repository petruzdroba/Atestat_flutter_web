import 'package:flutter/material.dart';

class ExamplePage extends StatelessWidget {
  final String testString;

  const ExamplePage(this.testString, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.amberAccent,
        child: Center(
            child: Text(testString,
                style: const TextStyle(
                  fontSize : 20,
                  color: Colors.black,
                )
            )
        )
    );
  }
}

// return Container(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height,
// color: Colors.amberAccent,
// child:  Center(
// child: ElevatedButton(onPressed: () {
// currentUsername.currentusername = '3434';
// }, child: const Text('tap'))),
// );
