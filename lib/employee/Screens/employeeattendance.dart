import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String _searchedEmployeeName = '';
  Future<List<QueryDocumentSnapshot>>? _attendanceData;

  void _searchPerformanceData() {
    setState(() {
      _attendanceData = FirebaseFirestore.instance
          .collection('attendance')
          .where('employeeName', isEqualTo: _searchedEmployeeName)
          .get()
          .then((snapshot) {
        return snapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Details'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter Employee Name',
            ),
            onChanged: (value) {
              _searchedEmployeeName = value;
            },
          ),
          ElevatedButton(
            onPressed: _searchPerformanceData,
            child: Text('Search'),
          ),
          Expanded(
            child: FutureBuilder<List<QueryDocumentSnapshot>>(
              future: _attendanceData,
              builder: (BuildContext context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    // Group attendance data by date
                    Map<String, List<Map<String, dynamic>>> groupedData = {};
                    snapshot.data!.forEach((doc) {
                      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

                      Timestamp timestamp = data['dateTime'] as Timestamp;
                      DateTime dateTime = timestamp.toDate();
                      String formattedDate = DateFormat.yMd().format(dateTime);

                      if (groupedData.containsKey(formattedDate)) {
                        groupedData[formattedDate]!.add(data);
                      } else {
                        groupedData[formattedDate] = [data];
                      }
                    });

                    // Create list items for each date
                    List<Widget> dateListItems = groupedData.entries.map((entry) {
                      String formattedDate = entry.key;
                      List<Map<String, dynamic>> attendanceList = entry.value;

                      // Create attendance list items for the date
                      List<Widget> attendanceListItems = attendanceList.map((attendance) {
                        String employeeName = attendance['employeeName'] ?? 'N/A';
                        bool status = attendance['status'] ?? false;
                        String statusText = status ? 'Present' : 'Absent';

                        return Column(
                          children: [
                            Text('Employee Name'),
                            Text(employeeName),
                            SizedBox(height: 10,),
                            Text('Status'),
                            Text(statusText),
                            SizedBox(height: 10,),
                          ],
                        );
                      }).toList();

                      return Column(
                        children: [
                          ListTile(
                            title: Text('Date'),
                            subtitle: Text(formattedDate),
                          ),
                          ...attendanceListItems,
                        ],
                      );
                    }).toList();

                    return ListView(
                      children: dateListItems,
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
