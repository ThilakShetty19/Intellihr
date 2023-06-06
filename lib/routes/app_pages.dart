import 'package:get/get.dart';
import 'package:intellihr/HR/binding/loginBinding.dart';
import 'package:intellihr/HR/screen/home.dart';
import 'package:intellihr/HR/screen/login.dart';
import 'package:intellihr/HR/screen/welcomescreen.dart';
import 'package:intellihr/employee/Screens/employeehome.dart';
import 'package:intellihr/employee/Screens/employeelogin.dart';
import 'package:intellihr/employee/binding/employeeloginbinding.dart';

class AppPages {
  static const INITIAL = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/employeelogin',
      page: () => Login(),
      binding: EmployeeLoginBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => Home(),
    ),
    GetPage(
      name: '/employeehome',
      page: () => EmployeeHome(),
    ),
  ];
}
