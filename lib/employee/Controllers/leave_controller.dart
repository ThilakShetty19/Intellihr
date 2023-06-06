import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intellihr/employee/model/leave.dart';


class LeaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addLeave(String employeeId, String employeeName, DateTime fromDate,
      DateTime toDate, String reason) {



    final leave = Leave(
        id: _firestore.collection("Leave Form").doc().id,
        employeeId: employeeId,
        employeeName: employeeName,
        fromDate: fromDate,
        toDate: toDate,
        reason: reason);

    _firestore.collection("Leave Form").doc(leave.id).set({
      "employeeId": leave.employeeId,
      "employeeName": leave.employeeName,
      "fromDate": leave.fromDate,
      "toDate": leave.toDate,
      "reason": leave.reason,
    }).then((value) {
      Get.snackbar("Success", "Leave form submitted successfully");
    }).catchError((error) {
      Get.snackbar("Error", "Failed to submit leave form");
    });
  }
}
