import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/presentation/add_alert_screen/bloc/add_alert_bloc.dart';

Future<void> getItAlertBloc() async {
  sl.registerFactory(
    () => AddAlertBloc(
      realTimeTradesUseCase: sl(),
    ),
  );
}
