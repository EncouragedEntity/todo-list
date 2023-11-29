import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GroupingDialog extends StatefulWidget {
  const GroupingDialog(this.groupByPriority, {super.key});
  final bool groupByPriority;

  @override
  State<GroupingDialog> createState() => _GroupingDialogState();
}

class _GroupingDialogState extends State<GroupingDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 36,
                      ),
                      Text(
                        "Sort by",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(widget.groupByPriority);
                        },
                        icon: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.calendar_number_outline,
                      color: Theme.of(context).highlightColor,
                    ),
                    title: const Text('Due Date'),
                    trailing: Radio(
                      fillColor: MaterialStatePropertyAll(
                          Theme.of(context).highlightColor),
                      value: false,
                      groupValue: widget.groupByPriority,
                      onChanged: (value) {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.warning_outline,
                      color: Theme.of(context).highlightColor,
                    ),
                    title: const Text('Priority'),
                    trailing: Radio(
                      fillColor: MaterialStatePropertyAll(
                          Theme.of(context).highlightColor),
                      value: true,
                      groupValue: widget.groupByPriority,
                      onChanged: (value) {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
