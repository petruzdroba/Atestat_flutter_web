import 'package:flutter/material.dart';

class ProductDetailed extends StatefulWidget {
  const ProductDetailed({super.key});

  @override
  State<ProductDetailed> createState() => _ProductDetailedState();
}

class _ProductDetailedState extends State<ProductDetailed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amberAccent,
    );
  }
}
