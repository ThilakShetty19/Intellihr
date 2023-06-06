

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/HR/controller/auth_controller.dart';
import 'package:intellihr/HR/screen/Attendance.dart';
import 'package:intellihr/HR/screen/Attendance_detail.dart';


import 'package:intellihr/HR/screen/addemployeescreen.dart';
import 'package:intellihr/HR/screen/benifits_page.dart';
import 'package:intellihr/HR/screen/leaveformscreen.dart';
import 'package:intellihr/HR/screen/offerletter.dart';
import 'package:intellihr/HR/screen/payslip.dart';

import 'package:intellihr/HR/screen/performanceevaluation.dart';
import 'package:intellihr/HR/screen/performanceview.dart';

import 'package:intellihr/HR/screen/relieving_page.dart';
import 'package:intellihr/HR/screen/vacancy_screen.dart';

import 'package:intellihr/HR/screen/viewemployees.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   /*String empId = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
*/
  /*void getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        empId = user.uid;
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR DASHBOARD"),
          backgroundColor: Color(0xff25bcbb),
        actions: [
          IconButton(
              onPressed: () {
                // this icon button is for the user to signout
                AuthController.authInstance.signOut();
              },
              icon: const Icon(Icons.power_off))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
      
               _buildGridItem(
              "Employee Profile", Icons.star, () {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
                  );

              } ),
          _buildGridItem(
              "Employee profile view", Icons.people, () {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => ViewEmployeeScreen()),
                  );

              } ),
       
               _buildGridItem(
              "Pay-Roll Management", Icons.money, () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PayRollPage()),
             );
           }
  
  ),  
          _buildGridItem("Employee benefits", Icons.card_giftcard,
             () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BenefitsPage()),
             );
           }
              
              
              ),
              _buildGridItem("Performance Evaluation", Icons.grade,
                () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PerformanceEvaluation()),
             );
           }), 
               _buildGridItem("Performance View", Icons.card_giftcard,
             () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PerformanceView()),
             );
           }),
               _buildGridItem("Relieving Letter", Icons.card_giftcard,
              () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RelievingLetter()),
             );
           }),
               _buildGridItem("Offer Letter", Icons.card_giftcard,
              () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OfferLetter()),
             );
           }),
               _buildGridItem("Recruitment", Icons.card_giftcard,
              () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VacancyScreen()),
             );
           }),
               _buildGridItem("Leave form view", Icons.card_giftcard,
               () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LeaveFormScreen()),
             );
           }),

               _buildGridItem("Attendence", Icons.check,
               () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendanceForm()),
             );
           }),
          _buildGridItem("Attendance view", Icons.check, 
         // () => Get.toNamed("/attendance")
            () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendanceList()),
             );
            }
          
          ),
        
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
