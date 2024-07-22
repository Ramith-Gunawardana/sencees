import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final signUpRepositoryProvider = Provider((ref) => SignUpRepo());

class SignUpRepo {
  Future<http.Response> signUp({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    String? surname,
    String? nickName,
  }) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/sign_up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
        'names': {
          'f_name': firstName,
          'l_name': lastName,
          'surname': surname,
          'nick_name': nickName,
        }
      }),
    );
    return response;
  }
}
