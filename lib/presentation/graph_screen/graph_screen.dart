import 'package:flutter/material.dart';
import 'package:tech_test_designli/core/my_theme.dart';

class GraphScreenProviderWrapper extends StatelessWidget {
  const GraphScreenProviderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const GraphScreen();
  }
}

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25),
          'Graph Screen',
        ),
        backgroundColor: MyColors.designlyOrange,
      ),
      backgroundColor: MyColors.designlyDarkBlue,
    );
  }
}
