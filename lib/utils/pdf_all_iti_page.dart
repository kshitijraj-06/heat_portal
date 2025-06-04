import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

import '../Models/Itinerary_model.dart';


class PdfGenerator {
  static Future<void> generateItineraryPdf(Itinerary itinerary) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Itinerary', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text('Tour Code: ${itinerary.tourCode}'),
          pw.Text('Destination: ${itinerary.destination}'),
          pw.Text('Duration: ${itinerary.duration} days'),
          pw.Text('Dates: ${itinerary.startDate} to ${itinerary.endDate}'),
          pw.Text('Agent: ${itinerary.agentName} (${itinerary.agentEmail}, ${itinerary.agentPhone})'),
          pw.Text('Group: ${itinerary.numAdult} adults, ${itinerary.numChildren} children'),
          pw.SizedBox(height: 16),
          pw.Text('Day-wise Itinerary:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.SizedBox(height: 8),
          ...itinerary.dayWiseList.map((day) => pw.Container(
            margin: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('${day.date?.split("T")[0]} - ${day.day}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Destination: ${day.destination}'),
                if (day.notes != null && day.notes!.isNotEmpty)
                  pw.Text('Notes: ${day.notes}'),
                pw.Divider(),
              ],
            ),
          )),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/itinerary_${itinerary.tourCode}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file
    await OpenFile.open(file.path);
  }
}
