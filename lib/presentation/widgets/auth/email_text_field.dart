import 'package:flutter/material.dart';

import '../styled_text_form_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StyledTextFormField(
      controller: controller,
      labelText: Text(
        'Email Address'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
