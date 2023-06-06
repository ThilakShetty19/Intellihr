import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/HR/controller/add_employee_controller.dart';
import 'package:intellihr/HR/model/employee_model.dart';



class AddEmployeeScreen extends StatelessWidget {
  final AddEmployeeController addEmployeeController =
      Get.put(AddEmployeeController());

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _salaryController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
         backgroundColor: Color(0xff25bcbb),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text, 
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid name';
                   }
                    return null;
                  },
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: InputDecoration(labelText: 'Contact Number',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    }
                      // Regular expression pattern to match numbers only
                   final numberRegExp = r'^[0-9]+$';
                    if (!RegExp(numberRegExp).hasMatch(value)) {
                    return 'Please enter a valid contact number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid address';
                   }
                    return null;
                  },
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _employeeIdController,
                  decoration: InputDecoration(labelText: 'Employee ID',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter employee ID';
                    }
                     // Validate that only numbers are entered
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid employee ID';
    }
                    return null;
                  },
                ),
                TextFormField(
                
                  controller: _salaryController,
                  decoration: InputDecoration(labelText: 'Basic Salary',labelStyle: TextStyle(color: Colors.black), ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter basic salary';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.black), ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                      }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.black), ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
               ElevatedButton(
                     style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xff25bcbb), // background (button) color
    foregroundColor: Colors.white, // foreground (text) color
  ),
       onPressed: () async {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        Name: _nameController.text,
        Number: _numberController.text,
        Address: _addressController.text,
        EmployeeId: _employeeIdController.text,
        Salary: _salaryController.text,
        Email: _emailController.text,
        Password: _passwordController.text,
      );
      await AddEmployeeController().addEmployee(
        name: employee.Name,
        contact: employee.Number,
        address: employee.Address,
        employeeId: employee.EmployeeId,
        basicSalary: double.tryParse(employee.Salary) ?? 0.0,
        email: employee.Email,
        password: employee.Password,
      );
    }
  },
  child: Text('Add Employee'),
),
              ])
          ))
      )
    );
                       
  }
}