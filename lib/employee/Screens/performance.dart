import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceView extends StatefulWidget {
  @override
  _PerformanceViewState createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  String _searchedEmployeeId = '';
  Future<QuerySnapshot>? _performanceData;

  void _searchPerformanceData() {
    setState(() {
      _performanceData = FirebaseFirestore.instance
          .collection('PerformanceDetails')
          .where('employeeId', isEqualTo: _searchedEmployeeId)
          .get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Details'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter Employee ID',
            ),
            onChanged: (value) {
              _searchedEmployeeId = value;
            },
          ),
          ElevatedButton(
            onPressed: _searchPerformanceData,
            child: Text('Search'),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _performanceData,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic>? data =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>?;
                        if (data != null) {
                          return ListTile(
                            title: Column(
                              children: [
                                Text('Name'),
                              Text(data['Name'] ?? 'N/A'),
                              SizedBox(height: 10,),
                                Text('Appraisal'),
                              Text(data['appraisal'] ?? 'N/A'),
                              SizedBox(height: 10,),
                              ],
                            ),
                        
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
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
