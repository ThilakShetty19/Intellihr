import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditAttendanceScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  EditAttendanceScreen({required this.documentSnapshot});

  @override
  _EditAttendanceScreenState createState() => _EditAttendanceScreenState();
}

class _EditAttendanceScreenState extends State<EditAttendanceScreen> {
  TextEditingController _employeeNameController = TextEditingController();
  bool _attendanceStatus = false;

  @override
  void initState() {
    super.initState();

    // Initialize the text field and attendance status with the existing data
    _employeeNameController.text = widget.documentSnapshot['employeeName'];
    _attendanceStatus = widget.documentSnapshot['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Attendance')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee Name'),
            TextFormField(
              controller: _employeeNameController,
              decoration: InputDecoration(hintText: 'Enter employee name'),
            ),
            SizedBox(height: 16.0),
            Text('Attendance Status'),
            SwitchListTile(
              title: Text(_attendanceStatus ? 'Present' : 'Absent'),
              value: _attendanceStatus,
              onChanged: (value) {
                setState(() {
                  _attendanceStatus = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Save the updated attendance details
                _updateAttendanceDetails();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateAttendanceDetails() {
    // Update the attendance details in Firestore
    final attendanceRef = FirebaseFirestore.instance.collection('attendance');
    attendanceRef
        .doc(widget.documentSnapshot.id)
        .update({
          'employeeName': _employeeNameController.text,
          'status': _attendanceStatus,
        })
        .then((value) => _onUpdateSuccess())
        .catchError((error) => _onUpdateError(error));
  }

  void _onUpdateSuccess() {
    // Handle the update success, if needed
    Navigator.pop(context, true);
  }

  void _onUpdateError(error) {
    // Handle the update error, if needed
    // You can show an error dialog or display an error message
    print('Update attendance error: $error');
  }
}
