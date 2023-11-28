import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/models/todo_item.dart';

import '../../blocs/events/todo_event.dart';

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
          context.read<TodoBloc>().add(TodoRemoveItemEvent(widget.item));
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
                  value: widget.item.isDone,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isChecked = newValue ?? false;
                      widget.item.isDone = isChecked;
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
            ),
          ),
        ),
      ),
    );
  }
}
