import 'package:get/get.dart';
import 'package:intellihr/employee/Controllers/loginauth_controller.dart';


class EmployeeLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
