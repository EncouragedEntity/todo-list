import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/models/todo/todo_item.dart';
import 'package:todo_list/models/todo/todo_priority.dart';
import 'package:todo_list/widgets/styled_text_form_field.dart';

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
  late TodoPriority selectedPriority;
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

  final priorityButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item?.title ?? "";
    item = widget.item ??
        TodoItem(
          title: "New task",
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );
    selectedPriority = item.priority;
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
            child: StyledTextFormField(
              controller: _titleController,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Priority',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ElevatedButton.icon(
                        key: priorityButtonKey,
                        onPressed: () {
                          RenderBox renderbox = priorityButtonKey
                              .currentContext!
                              .findRenderObject() as RenderBox;
                          final RenderBox overlay = Overlay.of(context)
                              .context
                              .findRenderObject() as RenderBox;
                          final RelativeRect position = RelativeRect.fromRect(
                            Rect.fromPoints(
                              renderbox.localToGlobal(Offset.zero,
                                  ancestor: overlay),
                              renderbox.localToGlobal(
                                  renderbox.size.bottomRight(Offset.zero),
                                  ancestor: overlay),
                            ),
                            Offset.zero & overlay.size,
                          );

                          showMenu<TodoPriority>(
                            context: context,
                            position: position,
                            items: [
                              ...TodoPriority.values.map((e) => PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        item.priority = e;
                                        selectedPriority = item.priority;
                                      });
                                    },
                                    value: e,
                                    child: Text(e.name),
                                  ))
                            ],
                          );
                        },
                        icon: Icon(
                          Ionicons.warning_outline,
                          color: currentPriorityColor,
                        ),
                        label: Text(
                          item.priority.name,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).highlightColor,
                ),
                foregroundColor: const MaterialStatePropertyAll(
                  Colors.white,
                ),
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 54)),
              ),
              onPressed: () {
                item.title = _titleController.text.isEmpty
                    ? "New task"
                    : _titleController.text;

                Navigator.of(context).pop(item);
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
