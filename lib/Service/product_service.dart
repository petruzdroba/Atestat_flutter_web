import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Class/ProductDetails.dart';

Future<http.Response> getProductList() {
  return http.get(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/product'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> getProductDetails() {
  return http.get(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/product_details'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<ProductDetails> postIdGetProductDetails(int id) async {
  final response = await http.post(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/post_id_product_details'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return ProductDetails.fromJson(responseData);
  } else {
    throw Exception('Failed to load product details');
  }
}