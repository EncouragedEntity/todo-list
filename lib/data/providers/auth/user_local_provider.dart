import 'package:localstore/localstore.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/data/providers/auth/auth_provider.dart';
import 'package:todo_list/logic/models/auth/user.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class UserLocalProvider extends AuthProvider {
  final collection = Localstore.instance.collection('users');

  @override
  Future<User?> changePassword(String oldPassword, String newPassword) async {
    final existingUser = await SessionManager().get('currentUser') as User?;
    if (existingUser == null) {
      return null;
    }
    Logger().w(existingUser);

    if (existingUser.password == oldPassword) {
      existingUser.password = newPassword;
      collection.doc(existingUser.email).set(existingUser.toJson());
      return existingUser;
    }
    return null;
  }

  @override
  Future<bool> deleteAccount() async {
    final existingUser = await SessionManager().get('currentUser') as User?;
    if (existingUser != null) {
      await collection.doc(existingUser.email).delete();
      return true;
    }
    return false;
  }

  @override
  Future<User?> logIn(String email, String password) async {
    final storedUser = await collection.doc(email).get();
    Logger().w(storedUser);

    if (storedUser == null || storedUser.isEmpty) {
      return null;
    }

    final storedPassword = storedUser['password'] as String;

    if (storedPassword == password) {
      final User user = User.fromJson(storedUser);
      return user;
    }
    return null;
  }

  @override
  Future<bool> logOut() async {
    return true;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    // await collection.doc(email).delete(); //! REMOVE LATER

    final existingUser = await collection.doc(email).get();
    Logger().w(existingUser);
    if (existingUser != null && existingUser.isNotEmpty) {
      return null;
    }
    final user = User(email: email, password: password);
    collection.doc(user.email).set(user.toJson());
    return user;
  }
}
