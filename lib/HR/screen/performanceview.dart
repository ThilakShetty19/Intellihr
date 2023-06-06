import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intellihr/HR/model/performance_model.dart';


class PerformanceView extends StatelessWidget {
  const PerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff25bcbb), 
        title: const Text("Employee Performance"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('PerformanceDetails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Performance> performanceList = snapshot.data!.docs.map((doc) => Performance.fromJson(doc.data() as Map<String, dynamic>)).toList();

          return ListView.builder(
            itemCount: performanceList.length,
            itemBuilder: (BuildContext context, int index) {
              final performance = performanceList[index];

              return ListTile(
                title: Text(performance.Name!),
                subtitle: Text(performance.Position!),
                trailing: Text(performance.appraisal!),
                onTap: () {
                  // handle tapping on a specific performance entry
                },
              );
            },
          );
        },
      ),
    );
  }
}
