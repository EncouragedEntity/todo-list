import 'package:flutter/material.dart';
import 'package:todo_list/widgets/styled_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return StyledButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      ),
    );
  }
}
