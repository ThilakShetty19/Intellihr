import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intellihr/HR/controller/performancecontroller.dart';

import 'package:intellihr/HR/model/performance_model.dart';
import 'package:intellihr/HR/screen/pie_chart_page.dart';

class PerformanceEvaluation extends StatelessWidget {



   final PerformanceController performanceController =Get.put(PerformanceController());

   final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _positionController = TextEditingController();

  final _projectsController = TextEditingController();

  final _completedProController = TextEditingController();

  final _activeProController = TextEditingController();

  final _employeeIdController = TextEditingController();

  final _appraisalController = TextEditingController();

  final _communicationController=TextEditingController();
  final _decisionmakingController=TextEditingController();
  final _cooperativeteamworkController=TextEditingController();

  
  
 final Map<String, double> dataMap = {
    'Communication Skills': 0.0,
    'Decision Making': 0.0,
    'Cooperative Teamwork': 0.0,
  };
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text('Add Performance'),backgroundColor: Color(0xff25bcbb), ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid name';
                   }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(labelText: 'Position',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a position';
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Please enter a valid position';
                   }
                    return null;
                  },
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _projectsController,
                  decoration: InputDecoration(labelText: 'Projects',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project details';
                    }
                    return null;
                  },
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _completedProController,
                  decoration: InputDecoration(labelText: 'Completed Projects',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter completed project details';
                    }
                    return null;
                  },
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _activeProController,
                  decoration: InputDecoration(labelText: 'Active Projects',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter active project details';
                    }
                    return null;
                  },
                ),
                  SizedBox(height: 10,),
                Text("Instruction: Please enter ratings from 1-10",style: TextStyle(color: Color(0xff25bcbb),fontStyle: FontStyle.italic),),
                SizedBox(height: 10,),
                 TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _appraisalController,
                  decoration: InputDecoration(labelText: 'Appraisal',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Appraisal points';
                    }
                    final ratingRegExp = RegExp(r'^([1-9]|10)$');
                          if (!ratingRegExp.hasMatch(value)) {
                            return 'Please enter a valid rating (1-10)';
                          }
                    return null;
                  },
                ),
                  TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _communicationController,
                  decoration: InputDecoration(labelText: 'Comunication Skills',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Comunication Skills points';
                    }
                    final ratingRegExp = RegExp(r'^([1-9]|10)$');
                          if (!ratingRegExp.hasMatch(value)) {
                            return 'Please enter a valid rating (1-10)';
                          }
                    return null;
                  },
                ),
                    TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _decisionmakingController,
                  decoration: InputDecoration(labelText: 'Decision Making',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Decision Making points';
                    }
                    final ratingRegExp = RegExp(r'^([1-9]|10)$');
                          if (!ratingRegExp.hasMatch(value)) {
                            return 'Please enter a valid rating (1-10)';
                          }
                    return null;
                  },
                ),
                   TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _cooperativeteamworkController,
                  decoration: InputDecoration(labelText: 'Cooperative teamwork',labelStyle: TextStyle(color: Colors.black), ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Cooperative teamwork points';
                    }
                    final ratingRegExp = RegExp(r'^([1-9]|10)$');
                          if (!ratingRegExp.hasMatch(value)) {
                            return 'Please enter a valid rating (1-10)';
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
                      return 'Please enter an employee ID';
                    }
                     final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid employee ID';
    }
                    return null;
                  },
                ),
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
               style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xff25bcbb), // background (button) color
    foregroundColor: Colors.white, // foreground (text) color
  ),
        onPressed: () {
        if (_formKey.currentState!.validate()) {
         // If the form is valid, save the data to Firebase Firestore
            final performance = Performance(
              Name: _nameController.text,
              Position: _positionController.text,
              Projects: _projectsController.text,
              CompletedPro: _completedProController.text,
              ActivePro: _activeProController.text,
              employeeId: _employeeIdController.text,
              appraisal: _appraisalController.text,
            );
            Get.find<PerformanceController>().addPerformance(performance);

             // Update the dataMap with the entered points
            dataMap['Communication Skills'] =
                double.parse(_communicationController.text);
            dataMap['Decision Making'] =
                double.parse(_decisionmakingController.text);
            dataMap['Cooperative Teamwork'] =
                double.parse(_cooperativeteamworkController.text);

            // Navigate to a new page to display the pie chart
            Get.to(PieChartPage(dataMap: dataMap));
           // Get.back();
        }
        },
        child: Text('Save'),
        ),
        )
              ])),
        ))

          );
  }
}