import 'package:logger/logger.dart';
import 'package:todo_list/providers/auth/auth_provider.dart';

class MockUserProvider extends AuthProvider {
  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    //* Assume that password changes successfully

    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("$oldPassword -> $newPassword");
    return true;
  }

  @override
  Future<bool> deleteAccount() async {
    //* Assume that you actually successfully delete user's account
    await Future.delayed(const Duration(milliseconds: 500));

    Logger().i("Account deleted");
    return true;
  }

  @override
  Future<bool> logIn(String email, String password) async {
    //* Assume that user successfully exists and log him in
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User with $email $password credentials was logged in");
    return true;
  }

  @override
  Future<bool> logOut() async {
    //* Assume that you actually successfully log user out
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User was logged out");
    return true;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    //* Assume that we successfully sign the user up
    await Future.delayed(const Duration(milliseconds: 500));
    Logger().i("User with $email $password credentials was signed up");
    return true;
  }
}
