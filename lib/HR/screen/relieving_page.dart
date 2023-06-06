import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share/share.dart';
import '../controller/relieving_controller.dart';

class RelievingLetter extends StatefulWidget {
  @override
  State<RelievingLetter> createState() => _RelievingLetterState();
}

class _RelievingLetterState extends State<RelievingLetter> {
  late TextEditingController _dateController;
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  final RelievingLetterController _controller =
      Get.put(RelievingLetterController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 173, 231, 118),
        title: Text(
          'Relieving Letter',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  "assets/images/logo.png",
                  scale: 2,
                )),
                TextFormField(
                  enabled: false,
                  controller: _dateController,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Date: ${_controller.Date.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.en,
                  decoration: InputDecoration(
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Employee Name:' ,// ${_controller.en.text}',
                      labelStyle: TextStyle(color: Colors.black), 
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (!nameRegExp.hasMatch(value)) {
                      _controller.en.text =
                          value.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
                      _controller.en.selection = TextSelection.fromPosition(
                          TextPosition(offset: _controller.en.text.length));
                    }
                  },
                ),
                TextFormField(
                  controller: _controller.cn,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Company Name: ',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Company Name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (!nameRegExp.hasMatch(value)) {
                      _controller.cn.text =
                          value.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
                      _controller.cn.selection = TextSelection.fromPosition(
                          TextPosition(offset: _controller.cn.text.length));
                    }
                  },
                ),
           InkWell(
  onTap: () async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _controller.dor.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  },
  child: IgnorePointer(
    child: TextFormField(
      controller: _controller.dor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        labelText: 'Date of Relieving:',
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Date of Relieving';
        }
        return null;
      },
    ),
  ),
),

                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text(
                      'Download Pdf',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _generatePDF();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generatePDF() async {
    final pdf = pdfLib.Document();

    // Add a page to the PDF document
    pdf.addPage(pdfLib.MultiPage(
      // Define the content of the page
      build: (context) => [
        pdfLib.Center(
          child: pdfLib.Text('Relieving Letter',
              style: pdfLib.TextStyle(
                  fontSize: 30, fontBold: pdfLib.Font.courierBold())),
        ),
        pdfLib.SizedBox(height: 20),
        pdfLib.Text(
            '${_controller.Date.text}\n\n${_controller.en.text}\n\nDear ${_controller.en.text},\n\nWe are writing to confirm that your employment with ${_controller.cn.text} will end on ${_controller.dor.text}.\n\nWe would like to take this opportunity to thank you for the contributions you have made to the company during your tenure. We appreciate your hard work and dedication, and we wish you all the best in your future endeavors.\n\nPlease note that your final paycheck will include any salary or benefits owed to you up until your last day of employment. We will also provide you with information about your options for continuing any health insurance coverage you have through the company.\n\nIf you have any questions or concerns, please don\'t hesitate to contact us. We are available to help you with the transition process and provide any additional information you may need.\n\nSincerely,\n\n${_controller.cn.text}',
            textAlign: pdfLib.TextAlign.justify),
      ],
    ));

    // Save the PDF document to a file
    final bytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/invoice.pdf';
    final file = File(path);
    final pdfBytes = await pdf.save();

    await file.writeAsBytes(pdfBytes.toList());

    // Share the PDF file using the share package
    Share.shareFiles([path], text: 'Invoice PDF');
    // Do something with the bytes, for example, send them in an email attachment
  }
}
