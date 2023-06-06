import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VacancyScreen extends StatefulWidget {
  @override
  _VacancyScreenState createState() => _VacancyScreenState();
}

class _VacancyScreenState extends State<VacancyScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _addVacancy() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      String location = _locationController.text;

      // Create a new document in the "vacancies" collection with the entered data
      firestore.collection('vacancies').add({
        'title': title,
        'description': description,
        'location': location,
      });

      // Clear the text fields after adding the vacancy
      _titleController.clear();
      _descriptionController.clear();
      _locationController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff25bcbb),
        title: Text('Vacancies'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid title';
                   }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid description';
                   }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid location';
                   }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff25bcbb),
                  foregroundColor: Colors.white,
                ),
                onPressed: _addVacancy,
                child: Text('Add Vacancy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
