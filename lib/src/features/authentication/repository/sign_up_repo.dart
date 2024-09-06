import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sencees/src/core/constants/app_urls.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';

final signUpRepositoryProvider = Provider((ref) => SignUpRepo());

class SignUpRepo {
  Future<http.Response> signUp(UserModel userModel) async {
    final response = await http.post(
      Uri.parse('${BASE_URL}sign_up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userModel.toJson()),
    );
    return response;
  }
}
