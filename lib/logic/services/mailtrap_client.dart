import 'package:logger/logger.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailTrapClient {
  //*Mailtrap credentials    USERNAME:PASSWORD    ---     9bc523879fc5fa:d04a3399eabc6d
  final _smtpServer = SmtpServer(
    'sandbox.smtp.mailtrap.io',
    port: 2525,
    username: "9bc523879fc5fa",
    password: "d04a3399eabc6d",
  );

  Future<bool> sendForgotPasswordLetter(
      String userEmail, String resetLink) async {
    final message = Message()
      ..from = const Address("9bc523879fc5fa@example.com", 'Todoshka')
      ..recipients.add(userEmail)
      ..subject = 'Forgot Password Request'
      ..html = '''
    <p style="font-size: 16px; color: #333; font-weight: bold;">Hello, our beloved user</p>
    <p style="font-size: 14px; color: #555;">We received a request to reset your password. If you made this request, please click the link below:</p>
    <a href="$resetLink" style="display: inline-block; margin-top: 10px; padding: 10px 15px; background-color: #007BFF; color: #fff; text-decoration: none; border-radius: 5px;">Reset Password</a>
    <p style="font-size: 14px; color: #555; margin-top: 10px;">If you didn't make this request, you can safely ignore this email.</p>
    <p style="font-size: 14px; color: #777; margin-top: 10px;">Thank you,</p>
    <p style="font-size: 14px; color: #777;">Todoshka team</p>
  ''';

    try {
      final sendReport = await send(message, _smtpServer);
      Logger().i('Forgot Password email sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      Logger().e('Forgot Password email not sent. ${e.message}');
      for (var p in e.problems) {
        Logger().e('Problem: ${p.code}: ${p.msg}');
      }
    } on Exception catch (e) {
      Logger().e('Forgot Password email not sent. $e');
    }
    return false;
  }
}
