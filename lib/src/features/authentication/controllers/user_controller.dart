import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';
import 'package:sencees/src/features/authentication/repository/user_repo.dart';

class UserController extends StateNotifier<AsyncValue<UserModel?>> {
  final UserRepo userRepository;

  UserController({required this.userRepository})
      : super(const AsyncValue.loading()) {
    fetchUser(); 
  }

  Future<void> fetchUser() async {
    try {
      final user = await userRepository.getUser();
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<UserModel?>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository: userRepository);
});
