import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/employee/Controllers/leave_controller.dart';

class LeaveForm extends StatelessWidget {
  final LeaveController _leaveController = Get.put(LeaveController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;

 Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final DateTime currentDate = DateTime.now();
      if (isFromDate) {
        if (selectedDate.isBefore(currentDate)) {
          // Invalid date selected for "From Date"
          // Show an error message or handle the invalid date.
          // Example:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invalid Date'),
              content: const Text('Please select a future date for "From Date".'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
        _fromDate = selectedDate;
      } else {
        if (selectedDate.isBefore(currentDate) || selectedDate.isBefore(_fromDate!)) {
          // Invalid date selected for "To Date"
          // Show an error message or handle the invalid date.
          // Example:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invalid Date'),
              content: const Text('Please select a future date after "From Date".'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
        _toDate = selectedDate;
      }
    }
  }

  String? _validateEmployeeId(String? value) {
    if (value!.isEmpty) {
      return "Please enter an Employee ID";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Employee ID must contain only numbers";
    }
    return null;
  }

  String? _validateEmployeeName(String? value) {
    if (value!.isEmpty) {
      return "Please enter an Employee Name";
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Employee Name must contain only letters";
    }
    return null;
  }
  String? _validateEmployeeReason(String? value) {
    if (value!.isEmpty) {
      return "Please enter an Reason";
    }
  
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _employeeIdController,
                  decoration: const InputDecoration(
                    labelText: "Employee ID",
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateEmployeeId,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _employeeNameController,
                  decoration: const InputDecoration(
                    labelText: "Employee Name",
                  ),
                  keyboardType: TextInputType.name,
                  validator: _validateEmployeeName,
                ),
                const SizedBox(height: 16),
                 
                TextFormField(
                    validator: _validateEmployeeReason,
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: "Reason",
                  ),
                  maxLines: 3,
                ),
                  const SizedBox(height: 16),
            Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
_fromDate == null
? "From Date"
: "From Date: ${_fromDate!.toLocal().toString().split(' ')[0]}",
style: const TextStyle(fontSize: 16),
),
ElevatedButton(
onPressed: () => _selectDate(context, true),
child: const Text("Select Date"),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
_toDate == null
? "To Date"
: "To Date: ${_toDate!.toLocal().toString().split(' ')[0]}",
style: const TextStyle(fontSize: 16),
),
ElevatedButton(
onPressed: () => _selectDate(context, false),
child: const Text("Select Date"),
),
],
),
const SizedBox(height: 16),
ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
_leaveController.addLeave(
_employeeIdController.text,
_employeeNameController.text,
_fromDate!,
_toDate!,
_reasonController.text,
);
}
},
child: const Text("Submit"),
),
],
),
),
),
),
);
}
}