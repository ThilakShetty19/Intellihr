import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmployeeController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  Future<void> addEmployee({
    required String name,
    required String contact,
    required String address,
    required String employeeId,
    required double basicSalary,
    required String email,
    required String password,
  }) async {
    try {
      await firestore.collection('employees').doc(employeeId).set({
        'name': name,
        'contact': contact,
        'address': address,
        'employeeId': employeeId,
        'basicSalary': basicSalary,
        'email': email,
        'password': password,
      });
      Get.snackbar('Success', 'Employee added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add employee: $e');
    }
  }
}
