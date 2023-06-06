import 'package:flutter/material.dart';




import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceForm extends StatefulWidget {
  @override
  _AttendanceFormState createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? _employeeName;
  bool? _attendanceStatus;
 //List<String> _employeeList = ['Niveditha', 'Melora', 'Clarin'];
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Get the current date and time
      final DateTime now = DateTime.now();

      // Create a Firestore document with the employee's attendance details
      await FirebaseFirestore.instance.collection('attendance').add({
        'employeeName': _employeeName,
        'status': _attendanceStatus,
        'dateTime': now,
      });

      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance recorded successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance'),backgroundColor: Color(0xff25bcbb), ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Employee Name'),
                value: _employeeName,
                items: _employeeList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _employeeName = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an employee';
                  }
                  return null;
                },
              ),*/
               TextFormField(
                decoration: InputDecoration(labelText: 'Employee Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the employee name';
                  }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid name';
                   }
                  return null;
                },
                onSaved: (value) {
                  _employeeName = value;
                },
              ),
              SizedBox(height: 16.0),
              Text('Attendance Status'),
              RadioListTile(
                title: Text('Present'),
                value: true,
                groupValue: _attendanceStatus,
                onChanged: (value) {
                  setState(() {
                    _attendanceStatus = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text('Absent'),
                value: false,
                groupValue: _attendanceStatus,
                onChanged: (value) {
                  setState(() {
                    _attendanceStatus = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xff25bcbb), // background (button) color
    foregroundColor: Colors.white, // foreground (text) color
  ),
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
