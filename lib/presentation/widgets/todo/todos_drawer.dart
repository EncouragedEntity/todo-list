import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../logic/blocs/auth_bloc.dart';
import '../../../logic/blocs/events/auth_events.dart';

class TodosDrawer extends StatelessWidget {
  const TodosDrawer({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldStateKey,
  }) : _key = scaffoldStateKey;

  final GlobalKey<ScaffoldState> _key;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              'Todooshka',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Ionicons.exit_outline),
              onPressed: () async {
                _key.currentState!.closeDrawer();
                context.read<AuthBloc>().add(AuthLogoutEvent());
                await Future.delayed(Duration.zero);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed('/');
              },
              label: const Text('Logout'),
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(Size(256, 16)),
                backgroundColor:
                    MaterialStatePropertyAll(Theme.of(context).highlightColor),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
