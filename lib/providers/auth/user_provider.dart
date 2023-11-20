import 'package:todo_list/providers/auth/auth_provider.dart';

// TODO: implement UserProvider
class UserProvider extends AuthProvider {
  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<void> logIn(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password) {
    throw UnimplementedError();
  }
}
