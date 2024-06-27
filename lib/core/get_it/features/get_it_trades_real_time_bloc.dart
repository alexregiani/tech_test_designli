import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/core/server_configuration_service.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source_implementation.dart';
import 'package:tech_test_designli/data/repositories/trades_repository_implementation.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';
import 'package:tech_test_designli/domain/use_cases/real_time_trades_use_case.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';

Future<void> getItTradesRealTimeBloc() async {
  sl
    ..registerFactory(
      () => TradesRealTimeBloc(
        realTimeTradesUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => RealTimeTradesUseCase(tradesRepository: sl()),
    )
    ..registerLazySingleton<TradesRepository>(
      () => TradesRepositoryImplementation(
        tradesDataSource: sl(),
      ),
    )
    ..registerSingleton<TradesDataSource>(
      TradesDataSourceImplementation(sl<ServerConfigurationService>()),
    );
}
