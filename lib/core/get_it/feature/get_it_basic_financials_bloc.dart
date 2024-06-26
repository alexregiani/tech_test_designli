import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/domain/use_cases/stock_financials_use_case.dart';
import 'package:tech_test_designli/presentation/graph_screen/bloc/stock_financials_bloc.dart';

Future<void> getItFinancialsBloc() async {
  sl
    ..registerFactory(
      () => StockFinancialsBloc(stockFinancialsUseCase: sl()),
    )
    ..registerLazySingleton(
      () => StockFinancialsUseCase(
        tradesRepository: sl(),
      ),
    );
}
