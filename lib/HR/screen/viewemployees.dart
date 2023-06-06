import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewEmployeeScreen extends StatelessWidget {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        backgroundColor: Color(0xff25bcbb),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('employees').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final employees = snapshot.data!.docs
              .map((doc) => Employee.fromJson(doc.data() as Map<String, dynamic>, doc.reference))
              .toList();
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return ListTile(

                title: Card(
                  child:  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.Name),
                      Text(employee.EmployeeId),
                      Text(employee.Email),
                      Text(employee.Address),
                      Text(employee.Number),
                    ],
                                  ),
                  ),
                ),
              
                trailing: IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, employee.reference);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, DocumentReference employeeRef) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Employee'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this employee?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteEmployee(employeeRef);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteEmployee(DocumentReference employeeRef) {
    return employeeRef.delete();
  }
}

class Employee {
  final String Name;
  final String Number;
  final String Address;
  final String EmployeeId;
  final String Salary;
  final String Email;
  final String Password;
  final DocumentReference reference;

  Employee({
    required this.Name,
    required this.Number,
    required this.Address,
    required this.EmployeeId,
    required this.Salary,
    required this.Email,
    required this.Password,
    required this.reference,
  });

  factory Employee.fromJson(Map<String, dynamic> json, DocumentReference reference) {
    return Employee(
      Name: json['name'],
      Number: json['contact'],
      Address: json['address'],
      EmployeeId: json['employeeId'],
      Salary: json['basicSalary'].toString(),
      Email: json['email'],
      Password: json['password'],
      reference: reference,
    );
  }
}
