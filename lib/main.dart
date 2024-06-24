import 'package:flutter/material.dart';
import 'package:tech_test_designli/presentation/add_alert_screen/add_alert_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Test Designli',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AddAlertScreen(),
    );
  }
}
