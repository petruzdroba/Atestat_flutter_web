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