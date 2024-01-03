import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> getUserbyUsername(String username) {
  return http.get(
    Uri.parse('http://localhost:8000/getUserByUsername/$username/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> logInUser(String username, String password) {
  return http.post(
    Uri.parse('http://localhost:8000/UserLoginView/'),
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
    Uri.parse('http://localhost:8000/UserRegistrationView/'),
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