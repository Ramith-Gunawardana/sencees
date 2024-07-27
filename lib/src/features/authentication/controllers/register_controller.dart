import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';
import 'package:sencees/src/features/authentication/repository/sign_up_repo.dart';

class RegisterController extends StateNotifier<UserModel?> {
  final SignUpRepo signUpRepo;
  String? successMessage;

  RegisterController(this.signUpRepo) : super(null);

  Future<void> registerUser(UserModel user) async {
    final response = await signUpRepo.signUp(user);

    if (response.statusCode == 201) {
      final successData = jsonDecode(response.body);
      successMessage = successData['message'];
      state = user;
    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error'];
      throw Exception(errorMessage);
    }
  }

  void clearUser() {
    state = null;
  }
}

final registerControllerProvider =
    StateNotifierProvider<RegisterController, UserModel?>((ref) {
  final signUpRepo = ref.read(signUpRepositoryProvider);
  return RegisterController(signUpRepo);
});
