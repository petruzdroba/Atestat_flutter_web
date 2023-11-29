import 'package:http/http.dart' as http;

Future<http.Response> getUserbyUsername(String username) {
  return http.get(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/getuser?username=$username'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}