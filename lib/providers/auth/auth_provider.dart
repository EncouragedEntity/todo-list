abstract class AuthProvider {
  Future<bool> logIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<bool> logOut();
  Future<bool> changePassword(String oldPassword, String newPassword);
  Future<bool> deleteAccount();
}
