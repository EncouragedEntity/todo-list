import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/blocs/events/auth_events.dart';
import 'package:todo_list/widgets/auth/email_text_field.dart';
import 'package:todo_list/widgets/auth/login_button.dart';
import 'package:todo_list/widgets/auth/password_text_field.dart';

import '../services/mailtrap_client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.message, this.isLoginMode = true});
  final String? message;
  final bool? isLoginMode;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginMode = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    isLoginMode = widget.isLoginMode ?? true;
  }

  void logIn() {
    if (_formKey.currentState!.validate()) {
      Logger().i("Form is valid. Logging in");
      final email = _emailController.text;
      final password = _passwordController.text;
      context.read<AuthBloc>().add(AuthLoginEvent(email, password));
    }
  }

  void signUp() {
    if (_formKey.currentState!.validate()) {
      Logger().i("Form is valid. Signing up");
      final email = _emailController.text;
      final password = _passwordController.text;
      context.read<AuthBloc>().add(AuthSignUpEvent(email, password));
    }
  }

  void forgotPassword() async {
    final sendingResult = await MailTrapClient().sendForgotPasswordLetter(
        "example@gmail.com", 'https://example.com/reset');
    Fluttertoast.cancel();
    if (sendingResult) {
      Fluttertoast.showToast(msg: 'Password reset letter sent');
    } else {
      Fluttertoast.showToast(msg: 'Error sending message');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "assets/icon_square.png",
                  scale: 1.05,
                ),
                const SizedBox(height: 20),
                Text(
                  isLoginMode ? "Welcome back!" : "Let's get started!",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        EmailTextField(
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),
                        PasswordTextField(
                          controller: _passwordController,
                          showForgotLable: isLoginMode,
                          onForgotPassword: forgotPassword,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                LoginButton(
                  text: isLoginMode ? 'Log in' : 'Sign up',
                  onPressed: isLoginMode ? logIn : signUp,
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLoginMode
                            ? "Don't have an account?"
                            : 'Already have an account?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginMode = !isLoginMode;
                          });
                        },
                        child: Text(
                          isLoginMode ? "Get started!" : 'Log in',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
