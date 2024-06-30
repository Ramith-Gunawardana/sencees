import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_model.dart';
import '../repository/login_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController {
  final LoginRepo _authRepo;

  AuthController({required LoginRepo authRepo}) : _authRepo = authRepo;

  Future<Login?> signIn(String username, String password) async {
    final response = await _authRepo.signIn(username, password);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Login.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error'];
      throw Exception(errorMessage);
    }
  }
}
