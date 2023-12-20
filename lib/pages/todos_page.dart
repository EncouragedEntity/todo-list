import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/blocs/events/auth_events.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/pages/add_edit_item_page.dart';

import '../blocs/states/todo_state.dart';
import '../models/todo/todo_item.dart';
import '../widgets/todo/todo_items_list.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool groupByPriority = false;
  final TextEditingController _searchController = TextEditingController();
  bool isSearchBarNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Provider<TodoBloc>(
      create: (ctx) => TodoBloc(),
      builder: (ctx, child) => SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (buildCtx, state) {
            return Scaffold(
              key: _key,
              drawer: Drawer(
                child: Column(
                  children: [
                    Text(
                      'Todooshka',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        _key.currentState!.closeDrawer();
                        context.read<AuthBloc>().add(AuthLogoutEvent());
                        await Future.delayed(Duration.zero);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).popAndPushNamed('/');
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 90,
                leading: IconButton(
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Ionicons.menu_outline,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                title: SizedBox(
                  width: 230,
                  child: SearchBar(
                    elevation: const MaterialStatePropertyAll(0),
                    leading: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    constraints:
                        const BoxConstraints(minHeight: 36, maxHeight: 36),
                    controller: _searchController,
                    onSubmitted: (value) {
                      ctx.read<TodoBloc>().add(TodoLoadAllItemsByTitleEvent(
                          itemTitle: _searchController.text));
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          isSearchBarNotEmpty = true;
                          return;
                        }
                        isSearchBarNotEmpty = false;
                      });
                    },
                    trailing: isSearchBarNotEmpty
                        ? [
                            IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  isSearchBarNotEmpty = false;
                                });
                                ctx
                                    .read<TodoBloc>()
                                    .add(TodoLoadAllItemsEvent());
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 20,
                              ),
                            )
                          ]
                        : null,
                  ),
                ),
                actions: [
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor.withOpacity(0.4),
                      ),
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromRadius(26)),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.ellipsis_horizontal_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
                backgroundColor:
                    Theme.of(context).highlightColor.withOpacity(0.70),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(72),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, bottom: 14),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today, ${DateFormat('d MMMM').format(DateTime.now())}",
                          ),
                          Text(
                            "My tasks",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).highlightColor,
                  ),
                ),
                onPressed: () async {
                  TodoItem? item = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (routeCtx) {
                        return const AddEditItemPage();
                      },
                    ),
                  );

                  if (item != null) {
                    // ignore: use_build_context_synchronously
                    ctx.read<TodoBloc>().add(TodoAddNewItemEvent(item));
                  }
                },
                icon: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: RefreshIndicator(
                  onRefresh: () async {
                    ctx.read<TodoBloc>().add(TodoLoadAllItemsByTitleEvent(
                        itemTitle: _searchController.text));
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 500,
                          child: TodoItemList(
                            itemTitle: _searchController.text,
                          ),
                        ),
                      ),
                    ],
                  )),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Ionicons.list, size: 34),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Ionicons.calendar_clear_outline, size: 34),
                    label: "",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
