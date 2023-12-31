// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../logic/blocs/events/todo_event.dart';
import '../../../logic/blocs/todo_bloc.dart';
import '../../../logic/models/todo/todo_item.dart';
import '../../pages/add_edit_item_page.dart';

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
  void didUpdateWidget(TodoItemListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item != widget.item) {
      setState(() {
        isChecked = widget.item.isDone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Opacity(
        opacity: isChecked ? 0.5 : 1.0,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: ListTile(
              enabled: !isChecked,
              onTap: () async {
                TodoItem? item = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return AddEditItemPage(item: widget.item);
                    },
                  ),
                );

                if (item != null) {
                  context.read<TodoBloc>().add(
                        TodoUpdateItemEvent(widget.item.id!, item),
                      );

                  context.read<TodoBloc>().add(TodoLoadAllItemsEvent());
                }
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

                    context
                        .read<TodoBloc>()
                        .add(TodoUpdateItemEvent(widget.item.id!, widget.item));
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
