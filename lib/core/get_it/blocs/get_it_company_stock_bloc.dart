import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_company_stock/bloc_company_stock_bloc.dart';

Future<void> getItCompanyStockBloc() async {
  sl
    ..registerFactory(
      () => CompanyStockBloc(stockCompanyUseCase: sl()),
    )
    ..registerLazySingleton(
      () => StockCompanyUseCase(
        tradesRepository: sl(),
      ),
    );
}
