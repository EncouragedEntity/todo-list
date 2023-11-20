import 'package:logger/logger.dart';
import 'package:todo_list/providers/auth/auth_provider.dart';

class MockUserProvider extends AuthProvider {
  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    //* Assume that password changes

    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("$oldPassword -> $newPassword");
  }

  @override
  Future<void> deleteAccount() async {
    //* Assume that you actually delete user's account
    await Future.delayed(const Duration(milliseconds: 500));

    Logger().i("Account deleted");
  }

  @override
  Future<void> logIn(String email, String password) async {
    //* Assume that user exists and log him in
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User with $email $password credentials was logged in");
  }

  @override
  Future<void> logOut() async {
    //* Assume that you actually log user out
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User was logged out");
  }

  @override
  Future<void> signUp(String email, String password) async {
    //* Assume that we sign the user up
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User with $email $password credentials was signed up");
  }
}
