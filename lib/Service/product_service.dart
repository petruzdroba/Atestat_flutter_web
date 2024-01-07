import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> getProductList() {
  return http.get(
    Uri.parse('http://localhost:8000/getAllProducts/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> getProductDetails(int id) {
  return http.get(
    Uri.parse('http://localhost:8000/getProductById/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> getPopularProduct() {
  return http.get(
    Uri.parse('http://localhost:8000/getPopularProduct/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> sellProduct(String name,double price, String image, String description, String author, List<String> images) {
  return http.post(
    Uri.parse('http://localhost:8000/ProductSellView/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'author': author,
      'images': images,
    }),
  );
}

Future<http.Response> deleteProduct(int id) {
  return http.post(
    Uri.parse('http://localhost:8000/DeleteProduct/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'product_id':id,
    }),
  );
}

