import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../logic/models/auth/user.dart';
import '../providers/auth/auth_provider.dart';

class UserRepository {
  final AuthProvider authProvider;

  UserRepository(this.authProvider);

  Future<User?> changePassword(String oldPassword, String newPassword) async {
    final newUser = await authProvider.changePassword(oldPassword, newPassword);
    await SessionManager().set('currentUser', newUser);
    return newUser;
  }

  Future<bool> deleteAccount() async {
    await SessionManager().remove('currentUser');
    return await authProvider.deleteAccount();
  }

  Future<User?> logIn(String email, String password) async {
    final user = await authProvider.logIn(email, password);
    if (user != null) {
      await SessionManager().set('currentUser', user);
      return user;
    }
    return null;
  }

  Future<bool> logOut() async {
    await SessionManager().remove('currentUser');
    return await authProvider.logOut();
  }

  Future<User?> signUp(String email, String password) async {
    return await authProvider.signUp(email, password);
  }
}
