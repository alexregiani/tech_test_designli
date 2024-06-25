import 'package:flutter/material.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/add_alert_screen/add_alert_screen.dart';
import 'package:tech_test_designli/presentation/graph_screen/graph_screen.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/watchlist_screen.dart';

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const WatchListProviderWrapper(),
                  ),
                );
              },
              child: const Text('Watch Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AddAlertProviderWrapper(),
                  ),
                );
              },
              child: const Text('Alert Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const GraphScreenProviderWrapper(),
                  ),
                );
              },
              child: const Text('Graph Screen'),
            )
          ],
        ),
      ),
    );
  }
}
