import 'package:todo_list/providers/auth/auth_provider.dart';

class UserRepository {
  final AuthProvider authProvider;

  UserRepository(this.authProvider);

  Future<void> changePassword(String oldPassword, String newPassword) async {
    await authProvider.changePassword(oldPassword, newPassword);
  }

  Future<void> deleteAccount() async {
    await authProvider.deleteAccount();
  }

  Future<void> logIn(String email, String password) async {
    await authProvider.logIn(email, password);
  }

  Future<void> logOut() async {
    await authProvider.logOut();
  }

  Future<void> signUp(String email, String password) async {
    await authProvider.signUp(email, password);
  }
}
