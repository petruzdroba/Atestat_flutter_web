import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Service/product_service.dart';
import 'package:flutter_club_blaga/Widgets/box_image_product_hover.dart';
import 'package:flutter_club_blaga/Widgets/loading_bar_cube.dart';

import '../Class/ProductDetails.dart';

class UserProductDisplay extends StatefulWidget {
  final List<int> productIds;

  const UserProductDisplay({Key? key, required this.productIds})
      : super(key: key);

  @override
  State<UserProductDisplay> createState() => _UserProductDisplayState();
}

class _UserProductDisplayState extends State<UserProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 16.0,
      runSpacing: 20.0,
      children: widget.productIds.map((id) {
        return FutureBuilder(
          future: getProductDetails(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error loading product $id');
              } else {
                final response = snapshot.data;
                if (response?.statusCode == 200) {
                  final jsonResponse = json.decode(response!.body);
                  final product = ProductDetails.fromJson(jsonResponse);
                  return BoxImageProductHover(product);
                } else if (response?.statusCode == 404) {
                  return Text('Error - product/id:$id not available!');
                } else {
                  return Text('Error ${response!.statusCode}');
                }
              }
            } else {
              return const LoadingBarCube(35.0, 900);
            }
          },
        );
      }).toList(),
    );
  }
}
