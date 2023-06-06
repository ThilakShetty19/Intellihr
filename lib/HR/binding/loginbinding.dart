import 'package:get/get.dart';
import 'package:intellihr/HR/controller/auth_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
