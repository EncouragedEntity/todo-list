import 'package:todo_list/providers/auth/auth_provider.dart';

// TODO: implement UserProvider
class UserProvider extends AuthProvider {
  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<bool> logIn(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp(String email, String password) {
    throw UnimplementedError();
  }
}
