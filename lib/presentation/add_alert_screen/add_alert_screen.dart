import 'package:flutter/material.dart';
import 'package:tech_test_designli/core/my_theme.dart';

class AddAlertProviderWrapper extends StatelessWidget {
  const AddAlertProviderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddAlertScreen();
  }
}

class AddAlertScreen extends StatelessWidget {
  const AddAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 25),
            'Add Alert'),
        backgroundColor: MyColors.designlyOrange,
      ),
      backgroundColor: MyColors.designlyDarkBlue,
    );
  }
}
