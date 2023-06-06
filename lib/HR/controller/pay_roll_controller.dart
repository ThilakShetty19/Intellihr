import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;

class PayRollController extends GetxController {
  final _empNameController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _amountController = TextEditingController();

  void _generatePDF() async {
    final pdf = pdfLib.Document();

    pdf.addPage(
      pdfLib.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfLib.Column(
            children: <pdfLib.Widget>[
              pdfLib.Text('Employee Name: ${_empNameController.text}'),
              pdfLib.Text('Invoice Number: ${_invoiceNumberController.text}'),
              pdfLib.Text('Amount: ${_amountController.text}'),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/invoice.pdf';
    final file = File(path);
    final pdfBytes = await pdf.save();

    await file.writeAsBytes(pdfBytes.toList());
    OpenFile.open(path);
  }

  @override
  void dispose() {
    _empNameController.dispose();
    _invoiceNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
