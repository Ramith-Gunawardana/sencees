import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';
import 'package:sencees/src/features/authentication/repository/sign_up_repo.dart';

class RegisterController extends StateNotifier<UserModel?> {
  final SignUpRepo signUpRepo;
  String? successMessage;

  RegisterController(this.signUpRepo) : super(null);

  Future<void> registerUser({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    String? surname,
    String? nickName,
  }) async {
    final response = await signUpRepo.signUp(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      surname: surname,
      nickName: nickName,
    );

    if (response.statusCode == 201) {
      final successData = jsonDecode(response.body);
      successMessage = successData['message'];

      state = UserModel(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        surname: surname,
        nickName: nickName,
      );
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
