import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../Services/create_iti.dart';

class PdfGenerator {
  static Future<void> generateItineraryPdf(CreateItineraryService service) async {
    final pdf = pw.Document();
    final ByteData logoData = await rootBundle.load('assets/heat_logo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final pw.MemoryImage logo = pw.MemoryImage(logoBytes);

    //final logo = await asset//networkImage('https://img.freepik.com/free-vector/bird-colorful-logo-gradient-vector_343694-1365.jpg?semt=ais_items_boosted&w=740');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.SizedBox(width: 300, height: 100, child: pw.Image(logo)),
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(top: 20),
          child: pw.Text('Generated on ${DateTime.now().toString().split(' ')[0]}', style: const pw.TextStyle(fontSize: 10)),
        ),
        build: (context) => [
          // Header with logo and title
          pw.Row(
            children: [
              //pw.SizedBox(width: 200, height: 50, child: pw.Image(logo)),
              pw.SizedBox(width: 20),
              pw.Text('TRAVEL ITINERARY', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ],
          ),
          pw.Divider(thickness: 2),
          pw.SizedBox(height: 20),

          // Agent & Client Information
          pw.Text('AGENT & CLIENT DETAILS', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('AGENT INFORMATION', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    _buildInfoRow('Name:', service.agentnamecontroller.text),
                    _buildInfoRow('Email:', service.agentemailcontroller.text),
                    _buildInfoRow('Phone:', service.agentphonecontroller.text),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('CLIENT INFORMATION', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    _buildInfoRow('Name:', service.clientnamecontroller.text),
                    _buildInfoRow('Email:', service.clientemailcontroller.text),
                    _buildInfoRow('Phone:', service.clientphonecontroller.text),
                    _buildInfoRow('Adults:', service.numAdultscontroller.text),
                    _buildInfoRow('Children:', service.numChildrencontroller.text),
                    _buildInfoRow('Nationality:', service.nationality.value),
                    _buildInfoRow('Emergency Contact:', service.client_emergency_contact.text),
                    _buildInfoRow('Language:', service.client_language.text),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 20),

          // Tour Overview
          pw.Text('TOUR OVERVIEW', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Tour Code:', service.tourCodecontroller.text),
                    _buildInfoRow('Destination:', service.destinationcontroller.text),
                    _buildInfoRow('Description:', service.descrptioncontroller.text),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Duration:', '${service.numberofdays.value} Days / ${service.numberofnights.value} Nights'),
                    _buildInfoRow('Start Date:', service.startdate.value?.toString().split(' ')[0] ?? 'Not set'),
                    _buildInfoRow('End Date:', service.enddate.value?.toString().split(' ')[0] ?? 'Not set'),
                    _buildInfoRow('Arrival Details:', service.arrivalcontroller.text),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.SizedBox(height: 20),

          // Day-wise Itinerary
          pw.Text('DAY-WISE ITINERARY', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 15),

          ...service.daywiseList.asMap().entries.map((entry) {
            final index = entry.key;
            final day = entry.value;

            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 0.5),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(8),
                    color: PdfColors.grey300,
                    child: pw.Text('DAY ${index + 1}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Destination:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                       // pw.Text(day.destinationController.text),
                        pw.SizedBox(height: 8),
                        pw.Text('Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        //pw.Text(day.detailsController.text),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Footer Notes
          pw.SizedBox(height: 30),
          pw.Text('Notes:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('• This itinerary is subject to change based on weather conditions and other factors'),
          pw.Text('• Please carry all necessary documents and medications'),
          pw.Text('• For any queries, contact your travel agent'),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text(value.isNotEmpty ? value : 'N/A'),
        ],
      ),
    );
  }
}