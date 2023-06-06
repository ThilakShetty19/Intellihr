import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/Constants/firebase_function.dart';

import '../../widgets/const.dart';
import '../../widgets/indicatot.dart';
import '../model/attendance_model.dart';

class AttendanceController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController dt = TextEditingController(
      text: DateTime.now().toString()); // set initial value to current time

  final FirebaseFunctions _functions = FirebaseFunctions();

  Rx<List<Attendance>> attend = Rx<List<Attendance>>([]);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController statusTextEditingController = TextEditingController();
  TextEditingController dtTextEditingController = TextEditingController();

  var itemCount = 0.obs;

  get imageFile => null;

  addAttendance(
    name,
    status,
    dt,
  ) {
    Attendance attendancess = Attendance(
      name: name,
      status: status,
      dt: dt,
    );
    attend.value.add(attendancess);
    itemCount.value = attend.value.length;
    nameTextEditingController.clear();
    statusTextEditingController.clear();
    dtTextEditingController.clear();
  }

  void createProfile() async {
    if (name.text.isNotEmpty && status.text.isNotEmpty && dt.text.isNotEmpty) {
      Indicator.showLoading();

      await _functions
          .attendanceDetail(name.text, status.text, dt.text)
          .then((value) {
        Indicator.closeLoading();
        showAlert("created sucessfully");
        // Get.back();
        // Get.toNamed(Routes.HOME);
      });
    } else {
      showAlert("details are required");
    }
  }

  void editProfile(Attendance model) async {
    Indicator.showLoading();

    if (name.text.isNotEmpty && status.text.isNotEmpty && dt.text.isNotEmpty) {
      if (imageFile == null) {
        Map<String, dynamic> map = {
          'Name': name.text,
          'Status': status.text,
          'Date & Time': dt.text,
        };
      } else {
        Map<String, dynamic> map = {
          'Name': name.text,
          'Status': status.text,
          'Date & Time': dt.text,
        };
      }
    } else {
      showAlert("All the fields are required");
    }

    Indicator.closeLoading();
    updateData();
  }

  void updateData() {
    Get.back();
    // Get.toNamed(Routes.HOME);
    if (Get.isRegistered<AttendanceController>()) {
      final _controller = Get.find<AttendanceController>();

      Indicator.showLoading();
    }
  }
}
