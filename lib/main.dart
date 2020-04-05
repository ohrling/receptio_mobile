import 'package:flutter/material.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/pages/recipe_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Makes the ui wait for the dependencies to be injected
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receptio',
      theme: ThemeData(
        primaryColor: Colors.green.shade600,
        accentColor: Colors.green.shade400,
      ),
      home: RecipePage(),
    );
  }
}
