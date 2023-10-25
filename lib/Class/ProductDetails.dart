import 'package:flutter_club_blaga/Class/Product.dart';

class ProductDetails extends Product{
  List<String> _images = [''];

  ProductDetails(String name, int id, String image, String description, List<String> list, List<String> images)
      : super(name, id, image, description, list) {
    _images = images;
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      json['name'] as String,
      json['id'] as int,
      json['image'] as String,
      json['description'] as String,
      List<String>.from(json['list'] as List),
      List<String>.from(json['images'] as List),
    );
  }
}