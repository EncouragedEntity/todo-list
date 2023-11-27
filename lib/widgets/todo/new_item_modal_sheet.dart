import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/models/todo_item.dart';

class NewTodoItemModalSheet extends StatefulWidget {
  const NewTodoItemModalSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTodoItemModalSheet> createState() => _NewTodoItemModalSheetState();
}

class _NewTodoItemModalSheetState extends State<NewTodoItemModalSheet> {
  final TextEditingController _titleController = TextEditingController();

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
                      autofocus: true,
                      controller: _titleController,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.calendar_number_outline,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.warning_outline,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.pricetag_outline,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.clipboard_outline,
                          color: Theme.of(context).highlightColor,
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
                      final item = TodoItem(
                          title: _titleController.text,
                          status: "To do",
                          dueDate: DateTime.now().add(const Duration(days: 1)));
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
