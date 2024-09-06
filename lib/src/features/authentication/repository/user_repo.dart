import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sencees/src/core/constants/app_urls.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepo());

class UserRepo {
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse('${BASE_URL}user'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load user: ${jsonDecode(response.body)['detail']}');
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }
}
