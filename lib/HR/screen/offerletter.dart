import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellihr/HR/controller/offerletter_controller.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share/share.dart';

class OfferLetter extends StatelessWidget {
  final OfferLetterController _controller = Get.put(OfferLetterController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 173, 231, 118),
        title: Text(
          'Offer Letter',
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _controller.jobTitle,
                    decoration: InputDecoration(
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Job Title:',
                      labelStyle: TextStyle(color: Colors.black), 
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a job title';
                      }
                         if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid job title';
                   }
                      return null;
                    },
                  ),
                ),
               /* TextFormField(
                  controller: _controller.startDate,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Start Date: ${_controller.startDate.text}',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the date';
                    }
                    return null;
                  },
                ),*/
 GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller:  _controller.startDate,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: 'Start Date: ${ _controller.startDate.text}',
                        labelStyle: TextStyle(color: Colors.black), 
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                
                TextFormField(
                  controller: _controller.en,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Employee Name: ${_controller.en.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the employee name';
                    }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid employee name';
                   }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.cn,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Company Name: ${_controller.cn.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a company name';
                    }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid company name';
                   }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.salary,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Salary: ${_controller.salary.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a salary';
                    }
                     final numberRegExp = r'^[0-9]+$';
                    if (!RegExp(numberRegExp).hasMatch(value)) {
                    return 'Please enter a valid salary';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.ws,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Work Schedule: ${_controller.ws.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the work schedule';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.location,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Location: ${_controller.location.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the location';
                    }
                       if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                     return 'Please enter a valid location';
                   }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller.jd,
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Job Description: ${_controller.jd.text}',
                    labelStyle: TextStyle(color: Colors.black), 
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the job description';
                    }
                     if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                     return 'Please enter a valid job description';
                   }
                    
                    return null;
                  },
                ),
            GestureDetector(
  onTap: () => _selectDate1(context),
  child: AbsorbPointer(
    child: TextFormField(
      controller: _controller.expdt,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        labelText: 'Expire Date: ${_controller.expdt.text}',
        labelStyle: TextStyle(color: Colors.black), 
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the expire date';
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


Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    _controller.startDate.text = DateFormat.yMd().format(picked);
  }
}


Future<void> _selectDate1(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    _controller.expdt.text = DateFormat.yMd().format(picked);
  }
}






  void _generatePDF() async {
    final pdf = pdfLib.Document();

    // Add a page to the PDF document
    pdf.addPage(
      pdfLib.MultiPage(
        // Define the content of the page
        build: (context) => [
          pdfLib.SizedBox(height: 20),
          pdfLib.Center(
            child: pdfLib.Text(
              'Offer Letter',
              style: pdfLib.TextStyle(
                  fontSize: 30, fontBold: pdfLib.Font.courierBold()),
            ),
          ),
          pdfLib.SizedBox(height: 20),
          pdfLib.Text(
              '${_controller.startDate.text}\n\n${_controller.en.text}\n\nDear ${_controller.en.text},\n\nI am pleased to offer you the position of ${_controller.jobTitle.text} with ${_controller.cn.text}. We believe that your skills, experience, and qualifications make you an excellent fit for our organization, and we are excited to have you join our team.\n\nYour start date will be ${_controller.startDate.text}, and you will report to Manager. Your starting salary will be ${_controller.salary.text}. You will work a ${_controller.ws.text} and your job duties will include ${_controller.jd.text} . You will be based at our ${_controller.location.text} office.\n\nAs a condition of your employment, you will be required to sign a non-compete and confidentiality agreement. Your employment with ${_controller.cn.text} is at-will, which means that either you or ${_controller.cn.text} may terminate your employment at any time, with or without cause and with or without notice.\n\nTo accept this offer, please sign and return this letter to me by ${_controller.expdt.text} . If you have any questions, please dont hesitate to contact me.\n\nWe are thrilled to have you join our team and look forward to your contributions.\n\nSincerely,\n\n${_controller.cn.text}',
              textAlign: pdfLib.TextAlign.justify),
        ],
      ),
    );

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
