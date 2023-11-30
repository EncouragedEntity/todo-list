import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/models/todo_priority.dart';

class ItemEditModalSheet extends StatefulWidget {
  const ItemEditModalSheet({
    super.key,
    this.item,
  });

  final TodoItem? item;

  @override
  State<ItemEditModalSheet> createState() => _ItemEditModalSheetState();
}

class _ItemEditModalSheetState extends State<ItemEditModalSheet> {
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
    return Padding(
      padding: MediaQuery.of(context)
          .viewInsets
          .add(const EdgeInsets.symmetric(horizontal: 10)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: -40,
            child: Text(
              'What would you like to do?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodySmall,
                      autofocus: true,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final chosenDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            currentDate: item.dueDate,
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          item.dueDate = chosenDate ??
                              DateTime.now().add(const Duration(days: 1));
                        },
                        icon: Icon(
                          Ionicons.calendar_number_outline,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          selectedItemBuilder: (ctx) => [
                            const SizedBox(
                              width: 40,
                            )
                          ],
                          items: [
                            ...TodoPriority.values.map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ))
                          ],
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
                      ),
                    ],
                  ),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).highlightColor,
                      ),
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromRadius(26)),
                    ),
                    onPressed: () {
                      item.title = _titleController.text.isEmpty
                          ? "New task"
                          : _titleController.text;

                      Navigator.of(context).pop(item);
                    },
                    icon: const Icon(Ionicons.arrow_up),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
