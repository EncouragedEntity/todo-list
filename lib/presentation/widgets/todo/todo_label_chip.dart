import 'package:flutter/material.dart';

class TodoLabelChip extends StatelessWidget {
  const TodoLabelChip({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      side: const BorderSide(width: 0, color: Colors.transparent),
      color: MaterialStatePropertyAll(color),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
