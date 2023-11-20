abstract class AuthProvider {
  Future<void> logIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> logOut();
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> deleteAccount();
}
