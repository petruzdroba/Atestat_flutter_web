import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> getUserbyUsername(String username) {
  return http.get(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/getuser?username=$username'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> logInUser(String username, String password) {
  return http.post(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/log_in'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username':username,
      'password':password
    }),
  );
}

Future<http.Response> signUpUser(String name,String username, String password) {
  return http.post(
    Uri.parse('https://cb5fbe06-e5ef-4282-b5e6-04b07cc24db8.mock.pstmn.io/sign_up'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name':name,
      'username':username,
      'password':password
    }),
  );
}