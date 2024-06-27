import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/core/server_configuration_service.dart';

void getItConfigurationService() {
  sl.registerSingleton<ServerConfigurationService>(
    ServerConfigurationService(useMockServer: false),
  );
}
