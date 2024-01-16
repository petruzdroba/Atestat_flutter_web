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

Future<http.Response> deleteUser(String username, String password) {
  return http.post(
    Uri.parse('http://localhost:8000/DeleteUserAccount/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username':username,
      'password':password
    }),
  );
}

Future<http.Response> addProductToUser(int id, String username) {
  return http.post(
    Uri.parse('http://localhost:8000/AddProductIdView/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'product_id':id,
      'username':username
    }),
  );
}

Future<http.Response> addProductToFavorite(int id, String username) {
  return http.post(
    Uri.parse('http://localhost:8000/AddFavoriteProduct/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'product_id':id,
      'username':username
    }),
  );
}

Future<http.Response> removeProductFromUser(int id, String username) {
  return http.post(
    Uri.parse('http://localhost:8000/RemoveProductIdView/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'product_id':id,
      'username':username
    }),
  );
}

Future<http.Response> editUser(String username, String newName, String newPfp) {
  return http.put(
    Uri.parse('http://localhost:8000/EditUser/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'checkUsername':username,
      'name':newName,
      'pfp':newPfp,
    }),
  );
}

