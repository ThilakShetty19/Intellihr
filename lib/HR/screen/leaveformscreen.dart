import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaveFormScreen extends StatefulWidget {
  @override
  _LeaveFormScreenState createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  CollectionReference leaveFormCollection =
      FirebaseFirestore.instance.collection('Leave Form');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: leaveFormCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
    
          List<LeaveForm> leaveForms = [];
    
          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            // Get the fields from the document
            String employeeId = document['employeeId'];
            String employeeName = document['employeeName'];
            DateTime fromDate =
                DateTime.parse(document['fromDate'].toDate().toString());
            String reason = document['reason'];
            DateTime toDate =
                DateTime.parse(document['toDate'].toDate().toString());
    
            // Create a LeaveForm object
            LeaveForm leaveForm = LeaveForm(
              employeeId: employeeId,
              employeeName: employeeName,
              fromDate: fromDate,
              reason: reason,
              toDate: toDate,
            );
    
            // Add the leave form to the list
            leaveForms.add(leaveForm);
          });
    
          return ListView.builder(
            itemCount: leaveForms.length,
            itemBuilder: (BuildContext context, int index) {
              LeaveForm leaveForm = leaveForms[index];
    
              // Display the leave form data in a widget
              return ListTile(
                title: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(leaveForm.employeeId,style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),),
                        Text(leaveForm.employeeName,style: TextStyle(color: Colors.green),),
                        Text(leaveForm.reason,style:TextStyle(fontWeight: FontWeight.bold),),
                        Text(
                        '${leaveForm.fromDate.toString()} - ${leaveForm.toDate.toString()}'),
                      ],
                    ),
                  ),
                ),
               
              
              );
            },
          );
        },
      ),
    );
  }
}

class LeaveForm {
  final String employeeId;
  final String employeeName;
  final DateTime fromDate;
  final String reason;
  final DateTime toDate;

  LeaveForm({
    required this.employeeId,
    required this.employeeName,
    required this.fromDate,
    required this.reason,
    required this.toDate,
  });
}
