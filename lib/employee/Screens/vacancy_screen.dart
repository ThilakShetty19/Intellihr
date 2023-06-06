import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VacancyScreen extends StatelessWidget {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacancies'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('vacancies').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final vacancies = snapshot.data!.docs.map((doc) => VacancyModel.fromJson(doc.data()as Map<String, dynamic>)).toList();
          return ListView.builder(
            itemCount: vacancies.length,
            itemBuilder: (context, index) {
              final employee = vacancies[index];
              return ListTile(
                title: Text(employee.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(employee.description),
                      Text(employee.location,style: TextStyle(color: Colors.green),),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class VacancyModel {
  final String title;
  final String description;
  final String location;


  VacancyModel({required this.title, required this.description, required this.location});
  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      title: json['title'],
      description: json['description'],
      location: json['location'],
     
     
    );
  }


}

