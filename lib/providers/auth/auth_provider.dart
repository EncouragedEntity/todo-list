import 'package:todo_list/models/auth/user.dart';

abstract class AuthProvider {
  Future<User?> logIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<bool> logOut();
  Future<User?> changePassword(String oldPassword, String newPassword);
  Future<bool> deleteAccount();
}
