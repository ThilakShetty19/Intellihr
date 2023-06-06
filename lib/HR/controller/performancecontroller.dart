import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intellihr/HR/model/performance_model.dart';


class PerformanceController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPerformance(Performance performance) async {
    try {
      await firestore
          .collection('PerformanceDetails')
          .doc(performance.employeeId)
          .set(performance.toJson());
      Get.snackbar('Success', 'Employee performance added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add employee performance');
    }
  }
}
