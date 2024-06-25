import 'package:get_it/get_it.dart';
import 'package:tech_test_designli/core/get_it/feature/get_it_trades_real_time_bloc.dart';

final sl = GetIt.instance;

Future<void> initGetItInjection() async {
  await getItTradesRealTimeBloc();
}
