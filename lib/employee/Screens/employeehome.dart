
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/employee/Screens/benifits_page.dart';
import 'package:intellihr/employee/Screens/employeeattendance.dart';
import 'package:intellihr/employee/Screens/leavescreen.dart';
import 'package:intellihr/employee/Screens/performance.dart';
import 'package:intellihr/employee/Screens/vacancy_screen.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({Key? key}) : super(key: key);

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
        actions: [
          IconButton(
              onPressed: () {
                // this icon button is for the user to signout
               // AuthController.authInstance.signOut();
               FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.power_off))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
      
               _buildGridItem(
              "Performance view", Icons.star, () {
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PerformanceView()),
  );

              } ),
          _buildGridItem(
              "Recruitment view", Icons.people, () {
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VacancyScreen()),
  );

              }),
        /*  _buildGridItem(
              "Leave form", Icons.calendar_today, () => Get.toNamed("/leave_form")),*/
               _buildGridItem(
              "Leave form", Icons.calendar_today, () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LeaveForm()),
  );}),  
          _buildGridItem("Employee benefits", Icons.card_giftcard,
                () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BenefitsPage()),
             );
           }
              ),
          _buildGridItem("Attendance view", Icons.check,   () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendancePage()),
             );
           }),
        //  _buildGridItem("Pay slip", Icons.money, () => Get.toNamed("/pay_slip")),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
