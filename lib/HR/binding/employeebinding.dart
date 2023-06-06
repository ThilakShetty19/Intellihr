import 'package:get/get.dart';
import 'package:intellihr/HR/controller/add_employee_controller.dart';


class AddemployeeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEmployeeController>(() => AddEmployeeController());
  }
}
