import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intellihr/HR/screen/editattendancescreen.dart';

class AttendanceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance List'),backgroundColor: Color(0xff25bcbb), ),
      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
    .collection('attendance')
    .orderBy('dateTime', descending: true)
    .snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
    final Map<DateTime, List<QueryDocumentSnapshot>> attendanceByDate = {};

    for (final document in documents) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final DateTime dateTime = data['dateTime'].toDate();

      // Group attendance data by date
      attendanceByDate[DateTime(dateTime.year, dateTime.month, dateTime.day)] =
          attendanceByDate[DateTime(dateTime.year, dateTime.month, dateTime.day)] ??
              [];
      attendanceByDate[DateTime(dateTime.year, dateTime.month, dateTime.day)]!.add(document);
    }

    final List<DateTime> dates = attendanceByDate.keys.toList();

    return ListView.builder(
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final List<QueryDocumentSnapshot> documents = attendanceByDate[dates[index]]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '${dates[index].day}/${dates[index].month}/${dates[index].year}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Attendance list
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                final String employeeName = data['employeeName'];
                final bool attendanceStatus = data['status'];
                final DateTime dateTime = data['dateTime'].toDate();

                return ListTile(
                  title: Text(employeeName),
                  subtitle: Text(
                    'Status: ${attendanceStatus ? "Present" : "Absent"}\nTime: ${dateTime.hour}:${dateTime.minute}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(
  icon: Icon(Icons.edit,color: Colors.green,),
  onPressed: () async {
    // Navigate to the edit attendance screen
    final bool success = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAttendanceScreen(
          documentSnapshot: documents[index],
        ),
      ),
    );

    if (success) {
      // Handle the edit success, if needed
      // For example, you can show a snackbar or update the attendance list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance edited'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  },
),

                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red),
                        onPressed: () async {
                          // Show a confirmation dialog before deleting the attendance
                          final bool shouldDelete = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Attendance'),
                                content: Text('Are you sure you want to delete this attendance?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (shouldDelete) {
                            // Delete the attendance document
                            await documents[index].reference.delete();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  },
),

      
      
      /*StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              final String employeeName = data['employeeName'];
              final bool attendanceStatus = data['status'];
              final DateTime dateTime = data['dateTime'].toDate();

              return ListTile(
                title: Text(employeeName),
                subtitle: Text(
                    'Status: ${attendanceStatus ? "Present" : "Absent"}\nDate: $dateTime'),
              );
            },
          );
        },
      ),*/





    );
  }
}
