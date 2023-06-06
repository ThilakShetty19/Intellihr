import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intellihr/widgets/const.dart';

class FirebaseFunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  Future<void> uploadDetails(
      // String Name,
      String Number,
      String Address,
      String Employee_Id,
      String Salary,
      String Email,
      String Password,
      String selectedName) async {
    try {
     
      DateTime time = DateTime.now();

      Map<String, dynamic> empDetails = {
        // 'Name': Name,
        'Number': Number,
        'Address': Address,
        'Employee_Id': Employee_Id,
        'Salary': Salary,
        'Email': Email,
        'Password': Password,
        'Name': selectedName,
      };

      await _firebaseFirestore
          .collection('EmployeeDetails')
          .doc(Employee_Id)
          .set(empDetails)
          .then((value) {});
    } catch (e) {
      showAlert("$e");
    }
  }

  

  Future<void> jobDetails(String jobtitle, String company, String jd,
      String exp, String location, String salary) async {
    try {
      String id = generateId();
      DateTime time = DateTime.now();

      Map<String, dynamic> jobDetails = {
        'Job Title': jobtitle,
        'Company Name': company,
        'Job Description': jd,
        'Experience': exp,
        'Location': location,
        'Salary': salary
      };

      await _firebaseFirestore
          .collection('JobOpenings')
          .doc(id)
          .set(jobDetails)
          .then((value) {});
    } catch (e) {
      showAlert("$e");
    }
  }

  Future<void> LeaveFormDetails(
      dt, en, emp_id, reason, from_date, to_date) async {
    try {
      String id = generateId();
      DateTime time = DateTime.now();

      Map<String, dynamic> leaveForm = {
        'Date': dt,
        'Employee Name': en,
        'Employee Id': emp_id,
        'Reason': reason,
        'From Date': from_date,
        'To Date': to_date,
      };

      await _firebaseFirestore
          .collection('Leave Form')
          .doc(id)
          .set(leaveForm)
          .then((value) {});
    } catch (e) {
      showAlert("$e");
    }
  }

  Future<void> attendanceDetail(
    String name,
    String status,
    String dt,
  ) async {
    try {
      String id = generateId();
      DateTime time = DateTime.now();

      Map<String, dynamic> attendanceDetails = {
        'Name': name,
        'Status': status,
        'Date & Time': dt,
      };

      await _firebaseFirestore
          .collection('Attendance Details')
          .doc(id)
          .set(attendanceDetails)
          .then((value) {});
    } catch (e) {
      showAlert("$e");
    }
  }
}
