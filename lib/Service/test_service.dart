import 'package:http/http.dart' as http;

Future<http.Response> getTestService() {
  return http.get(
    Uri.parse('http://localhost:8000/get_string/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}