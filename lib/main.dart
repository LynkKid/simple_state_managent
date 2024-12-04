import 'package:flutter/material.dart';
import 'package:my_state_management_app/login/ui/MyLoginScreen.dart';

import 'utils/pref_utils.dart';
import 'utils/state_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PrefUtils().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final stateManager = SimpleState();

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      stateManager: stateManager,
      child: const MaterialApp(
        title: 'SimpleState Demo',
        home: MyLoginScreen(),
      ),
    );
  }
}
