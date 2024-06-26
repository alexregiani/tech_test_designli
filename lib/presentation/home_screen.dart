import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.designlyDarkBlue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.designlyOrange,
        title: Text(
          'Designli Test by Alex Regiani',
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.designlyOrange,
              ),
              onPressed: () {
                context.goNamed(Navigation.watchListScreen.name);
              },
              child: const Text(
                style: TextStyle(color: MyColors.designlyDarkBlue),
                'Watch Screen',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.designlyOrange,
              ),
              onPressed: () {
                context.goNamed(Navigation.alertScreen.name);
              },
              child: const Text(
                style: TextStyle(color: MyColors.designlyDarkBlue),
                'Alert Screen',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.designlyOrange,
              ),
              onPressed: () {
                context.goNamed(Navigation.graphScreen.name);
              },
              child: const Text(
                style: TextStyle(color: MyColors.designlyDarkBlue),
                'Graph Screen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
