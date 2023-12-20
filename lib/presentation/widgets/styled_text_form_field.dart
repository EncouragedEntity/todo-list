import 'package:flutter/material.dart';

class StyledTextFormField extends StatelessWidget {
  const StyledTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final Widget? labelText;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 6),
          child: labelText,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey.shade400.withAlpha(60),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
