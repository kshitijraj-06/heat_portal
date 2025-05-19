import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../Services/create_iti.dart';

class PdfGenerator {
  static Future<void> generateItineraryPdf(CreateItineraryService service) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text("DAY WISE ITINERARY", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text("Duration      : ${service.numberofnights.value} Nts / ${service.numberofdays.value} Days"),
          pw.Text("Destination : ${service.tourCodecontroller.text} (${service.destinationcontroller.text})"),
          pw.SizedBox(height: 20),

          ...service.dayWiseControllers.asMap().entries.map((entry) {
            int index = entry.key;
            String text = entry.value.text.trim();

            if (text.isEmpty) return pw.SizedBox.shrink();

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Day : ${index + 1}".padRight(5) + "Day ${index + 1}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text(text, style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
