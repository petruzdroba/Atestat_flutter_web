import 'package:flutter_club_blaga/Class/Product.dart';

class ProductDetails extends Product{
  String _author ='';
  List<String> _images = [''];

  ProductDetails(String name, double price,int id, String image, String description, List<String> list, String author,List<String> images)
      : super(name,price, id, image, description, list) {
    _author = author;
    _images = images;
  }

  String get author => _author;

  set author(String value) {
    _author = value;
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
      List<String>.from(json['list'] as List),
      json['author'] as String,
      List<String>.from(json['images'] as List),
    );
  }
}