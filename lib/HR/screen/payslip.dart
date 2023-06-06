import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';

import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

class PayRollPage extends StatefulWidget {
  @override
  _PayRollPageState createState() => _PayRollPageState();
}

class _PayRollPageState extends State<PayRollPage> {
  String _invoiceNumber = "0001";
  String? _name;
  DateTime? _selectedDate;
  double _basicSalary = 0.0;
  double _hra = 0.0;
  double _grossSalary = 0.0;
  double _pf = 0.0;
  double _netAmount = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculateGrossSalary() {
    setState(
      () {
        _grossSalary = _basicSalary + _hra;
        _pf = 0.1 * _basicSalary;
        _netAmount = _grossSalary - _pf;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: Color(0xff25bcbb),
        title: Text("Pay Slip"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Invoice Number: $_invoiceNumber",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid name';
                   }
                    return null;
                  },
                  onSaved: (String? value) {
                    _name = value!;
                  },
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Date",
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "Select Date"
                              : DateFormat.yMd().format(_selectedDate!),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Basic Salary",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Basic Salary is required";
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    _basicSalary = double.parse(value);
                    _calculateGrossSalary();
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "HRA",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "HRA is required";
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    _hra = double.parse(value);
                    _calculateGrossSalary();
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  "Gross Salary: $_grossSalary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "PF: $_pf",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Net Amount: $_netAmount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xff25bcbb), // background (button) color
    foregroundColor: Colors.white, // foreground (text) color
  ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await generatePdf();
                      }
                    },
                    child: Text("Download Pdf"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    // Create a PDF document.
    final pdf = pw.Document();

    // Add a page to the document.
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Pay Slip",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text("Invoice Number: $_invoiceNumber"),
              pw.SizedBox(height: 3),
              pw.Text("Name: $_name"),
              pw.SizedBox(height: 3),
              pw.Text("Date: ${DateFormat.yMd().format(_selectedDate!)}"),
              pw.SizedBox(height: 3),
              pw.Text("Basic Salary: $_basicSalary"),
              pw.SizedBox(height: 3),
              pw.Text("HRA: $_hra"),
              pw.SizedBox(height: 3),
              pw.Text("Gross Salary: $_grossSalary"),
              pw.SizedBox(height: 3),
              pw.Text("PF: $_pf"),
              pw.SizedBox(height: 3),
              pw.Text(
                "Net Amount: $_netAmount",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    // Save the document to a temporary file.
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/pay_slip_$_invoiceNumber.pdf");
    await file.writeAsBytes(await pdf.save());

    // Open the file using the device's default PDF viewer.
    await OpenFile.open(file.path);
     // Share the PDF file using the share package.
  Share.shareFiles([file.path]);
  }
}











