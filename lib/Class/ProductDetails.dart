import 'package:flutter_club_blaga/Class/Product.dart';

class ProductDetails extends Product{
  List<String> _images = [''];

  ProductDetails(String name, double price,int id, String image, String description, String author,List<String> images)
      : super(name,price, id, image, description,author) {

    _images = images;
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      json['name'] as String,
      json['price'] as double,
      json['id'] as int,
      json['image'] as String,
      json['description'] as String,
      json['author'] as String,
      List<String>.from(json['images'] as List),
    );
  }
}