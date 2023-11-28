import 'package:flutter/material.dart';
import 'package:todo_list/widgets/styled_text_form_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.showForgotLable,
    required this.onForgotPassword,
  });
  final TextEditingController controller;
  final bool showForgotLable;
  final void Function() onForgotPassword;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return StyledTextFormField(
      controller: widget.controller,
      labelText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Password'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
          ),
          if (widget.showForgotLable)
            TextButton(
              onPressed: widget.onForgotPassword,
              child: Text(
                'Forgot password?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
        ],
      ),
      obscureText: obscureText,
      suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            !obscureText ? Icons.visibility : Icons.visibility_off,
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (!RegExp(
                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
            .hasMatch(value)) {
          return 'Password must be at least 8\ncharacters, contain 1 uppercase\nletter and 1 lowercase';
        }
        return null;
      },
    );
  }
}
