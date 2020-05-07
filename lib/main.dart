import 'package:flutter/material.dart';
import 'package:receptio_mobile/core/routes/route_generator.dart';
import 'package:receptio_mobile/injection.dart';

void main() {
  configureInjection(Env.prod);
  runApp(Receptio());
}

class Receptio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receptio',
      theme: ThemeData(
        primaryColor: Colors.green.shade600,
        accentColor: Colors.green.shade400,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
