import 'package:tech_test_designli/core/get_it/get_it_injection.dart';

class InitBootstrapper {
  static Future<void> init()async {
    await initGetItInjection();
  }

}
