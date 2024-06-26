import 'package:tech_test_designli/core/configuration_service.dart';
import 'package:tech_test_designli/core/get_it/get_it_injection.dart';

void getItConfigurationService() {
  sl.registerSingleton<ConfigurationService>(
    ConfigurationService(useMockServer: true),
  );
}
