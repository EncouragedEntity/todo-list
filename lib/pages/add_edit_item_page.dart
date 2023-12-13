import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/models/todo_priority.dart';

class AddEditItemPage extends StatefulWidget {
  const AddEditItemPage({
    super.key,
    this.item,
  });

  final TodoItem? item;

  @override
  State<AddEditItemPage> createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final TextEditingController _titleController = TextEditingController();
  late final TodoItem item;
  TodoPriority selectedPriority = TodoPriority.medium;
  Color get currentPriorityColor {
    switch (selectedPriority) {
      case TodoPriority.high:
        return Colors.red;
      case TodoPriority.medium:
        return Colors.orange;
      case TodoPriority.low:
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item?.title ?? "";
    item = widget.item ??
        TodoItem(
          title: "New task",
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What would you like to do?'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: Theme.of(context).textTheme.bodySmall,
              autofocus: true,
              controller: _titleController,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due date',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ElevatedButton.icon(
                        label: Text(item.formattedDate),
                        onPressed: () async {
                          final chosenDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: item.dueDate,
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          setState(() {
                            item.dueDate = chosenDate ??
                                DateTime.now().add(const Duration(days: 1));
                          });
                        },
                        icon: Icon(
                          Ionicons.calendar_number_outline,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Priority',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Elevated(
                        hint: const Text('Priority'),
                        items: [],
                        onChanged: (value) {
                          setState(() {
                            item.priority = value ?? TodoPriority.medium;
                            selectedPriority = item.priority;
                          });
                        },
                        value: item.priority,
                        icon: Icon(
                          Ionicons.warning_outline,
                          color: currentPriorityColor,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            showMenu(
                                context: context,
                                position: RelativeRect(),
                                items: [
                                  ...TodoPriority.values
                                      .map((e) => DropdownButton(
                                            value: e,
                                            child: Text(e.name),
                                          ))
                                ]);
                            item.priority = value ?? TodoPriority.medium;
                            selectedPriority = item.priority;
                          });
                        },
                        icon: Icon(
                          Ionicons.warning_outline,
                          color: currentPriorityColor,
                        ),
                        label: Text(item.priority.name),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).highlightColor,
              ),
              foregroundColor: const MaterialStatePropertyAll(
                Colors.white,
              ),
            ),
            onPressed: () {
              item.title = _titleController.text.isEmpty
                  ? "New task"
                  : _titleController.text;

              Navigator.of(context).pop(item);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
