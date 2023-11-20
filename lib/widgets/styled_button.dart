import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(5),
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).highlightColor,
        ),
        foregroundColor: MaterialStatePropertyAll(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 46,
          vertical: 24,
        ),
        child: child,
      ),
    );
  }
}
