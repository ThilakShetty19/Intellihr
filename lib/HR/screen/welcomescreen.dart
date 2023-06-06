import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xff18203d),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 250,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to IntelliHR',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff25bcbb), // background (button) color
                foregroundColor: Colors.white, // foreground (text) color
              ),
              onPressed: () {
                Get.toNamed('/login'); // Navigate to the HR admin login screen
              },
              child: Text('HR Admin Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                    '/employeelogin'); // Navigate to the employee login screen
              },
              child: Text('Employee Login'),
            ),
          ],
        ),
      ),
    );
  }
}
