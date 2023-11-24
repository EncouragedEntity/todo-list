import 'package:todo_list/providers/auth/auth_provider.dart';

class UserRepository {
  final AuthProvider authProvider;

  UserRepository(this.authProvider);

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    return await authProvider.changePassword(oldPassword, newPassword);
  }

  Future<bool> deleteAccount() async {
    return await authProvider.deleteAccount();
  }

  Future<bool> logIn(String email, String password) async {
    return await authProvider.logIn(email, password);
  }

  Future<bool> logOut() async {
    return await authProvider.logOut();
  }

  Future<bool> signUp(String email, String password) async {
    return await authProvider.signUp(email, password);
  }
}
