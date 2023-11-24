import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/models/todo_item.dart';

import 'todo_label_chip.dart';

class TodoItemListTile extends StatefulWidget {
  const TodoItemListTile({super.key, required this.item});
  final TodoItem item;

  @override
  State<TodoItemListTile> createState() => _TodoItemListTileState();
}

class _TodoItemListTileState extends State<TodoItemListTile> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.item.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: IconButton.filled(
            color: Colors.white,
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            onPressed: () {},
            icon: const Icon(
              Ionicons.trash_outline,
            ),
          ),
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        }
        return false;
      },
      key: ValueKey(widget.item.id),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Opacity(
          opacity: isChecked ? 0.5 : 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: ListTile(
              enabled: !isChecked,
              onTap: () {
                Logger().i("Tile was tapped");
              },
              focusColor: Colors.transparent,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Checkbox(
                  activeColor: Theme.of(context).highlightColor,
                  shape: const CircleBorder(),
                  side: BorderSide(
                    color: Theme.of(context).highlightColor,
                    width: 2,
                  ),
                  value: isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isChecked = newValue ?? false;
                    });
                  },
                ),
              ),
              title: Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isChecked ? Colors.grey : null,
                ),
              ),
              subtitle: Text(
                widget.item.formattedDateDayMonth,
                style: TextStyle(
                  color: isChecked ? Colors.grey : Colors.grey,
                  fontSize: 12,
                ),
              ),
              trailing: widget.item.label != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 12),
                      child: Wrap(
                        children: [
                          TodoLabelChip(
                            color: isChecked
                                ? const Color(0xFFF2A820).withOpacity(0.5)
                                : const Color(0xFFF2A820),
                            text: widget.item.label!,
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
