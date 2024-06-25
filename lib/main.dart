import 'package:flutter/material.dart';
import 'package:tech_test_designli/core/init_bootsrapper.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/homepage.dart';

void main() {
  InitBootstrapper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Test Designli',
      theme: MyTheme.theme,
      home: const HomeScreen(),
    );
  }
}
