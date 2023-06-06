import 'package:get/get.dart';

import 'package:intellihr/HR/controller/performancecontroller.dart';

class PerformanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerformanceController());
  }
}
