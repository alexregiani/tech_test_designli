import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/presentation/add_alert_screen/add_alert_screen.dart';
import 'package:tech_test_designli/presentation/graph_screen/graph_screen.dart';
import 'package:tech_test_designli/presentation/home_screen.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/watchlist_screen.dart';

enum Navigation {
  homeScreen('/'),
  watchListScreen('watch list'),
  alertScreen('alert screen'),
  graphScreen('graph screen');

  const Navigation(this.name);
  final String name;
}

final router = GoRouter(
  routes: [
    GoRoute(
      name: Navigation.homeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: Navigation.watchListScreen.name,
      path: '/watchlist',
      builder: (context, state) => const WatchlistScreen(),
    ),
    GoRoute(
      name: Navigation.alertScreen.name,
      path: '/addalert',
      builder: (context, state) => const AddAlertScreen(),
    ),
    GoRoute(
      name: Navigation.graphScreen.name,
      path: '/graphscreen',
      builder: (context, state) => const GraphScreen(),
    ),
  ],
);
