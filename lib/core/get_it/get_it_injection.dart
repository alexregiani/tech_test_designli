import 'package:get_it/get_it.dart';
import 'package:tech_test_designli/core/get_it/blocs/get_it_basic_financials_bloc.dart';
import 'package:tech_test_designli/core/get_it/blocs/get_it_company_stock_bloc.dart';
import 'package:tech_test_designli/core/get_it/blocs/get_it_configuration_service.dart';
import 'package:tech_test_designli/core/get_it/blocs/get_it_trades_real_time_bloc.dart';

final sl = GetIt.instance;

Future<void> initGetItInjection() async {
  getItConfigurationService();
  await getItTradesRealTimeBloc();
  await getItCompanyStockBloc();
  await getItFinancialsBloc();
}
