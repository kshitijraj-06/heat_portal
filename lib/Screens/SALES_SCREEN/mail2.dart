import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Email {
  final String senderName;
  final String senderEmail;
  final String subject;
  final DateTime date;
  final String? htmlContent;
  final String? plainText;
  final List<Attachment> attachments;

  Email({
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.date,
    this.htmlContent,
    this.plainText,
    this.attachments = const [],
  });
}

class Attachment {
  final String fileName;
  final String mimeType;
  final dynamic data; // e.g. Uint8List or file path

  Attachment({required this.fileName, required this.mimeType, this.data});
}

class EmailDetailPage extends StatelessWidget {
  final Email email;

  EmailDetailPage({required this.email});

  @override
  Widget build(BuildContext context) {
    // Helper to pick an icon based on MIME type
    IconData getIcon(String mime) {
      if (mime.contains('pdf')) {
        return Icons.picture_as_pdf; // PDF icon:contentReference[oaicite:8]{index=8}
      } else if (mime.contains('image')) {
        return Icons.image;
      } else {
        return Icons.attach_file;
      }
    }

    // Dummy open function (replace with actual file opening logic, e.g. using url_launcher or open_file)
    void openAttachment(Attachment attachment) {
      print('Open attachment: ${attachment.fileName}');
    }

    // Detect LinkedIn/Facebook senders for special footer
    bool isLinkedIn = email.senderEmail.toLowerCase().contains('linkedin.com');
    bool isFacebook = email.senderEmail.toLowerCase().contains('facebook.com');

    // Extract unsubscribe/help links from HTML or plain body (simple regex example)
    String bodyText = email.htmlContent ?? email.plainText ?? '';
    RegExp linkRegEx = RegExp(
        r'<a[^>]*>([^<]*(unsubscribe|help|support|legal)[^<]*)<\/a>',
        caseSensitive: false);
    Iterable<RegExpMatch> matches = linkRegEx.allMatches(bodyText);
    List<Map<String, String>> footerLinks = [];
    for (var m in matches) {
      final linkText = m.group(1)!;
      // Simplified extraction of href attribute
      RegExp hrefReg = RegExp(r'href=["\"]');
      var hrefMatch = hrefReg.firstMatch(bodyText.substring(m.start, m.end));
      if (hrefMatch != null) {
        footerLinks.add({'text': linkText.trim(), 'url': hrefMatch.group(1)!});
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Email Detail')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Subject line (bold, like Gmail)
          Text(
            email.subject,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          // Sender name/email and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sender info (name bold, email gray)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(email.senderName, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(email.senderEmail, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              // Date (right aligned)
              Text(
                '${email.date.year}/${email.date.month}/${email.date.day}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          Divider(height: 32),

          // Email content: HTML (using flutter_html) or plain text fallback:contentReference[oaicite:9]{index=9}
          if (email.htmlContent != null)
            Html(data: email.htmlContent!)
          else
            Text(email.plainText ?? '', style: TextStyle(fontSize: 16)),

          // Attachments section
          if (email.attachments.isNotEmpty) ...[
            SizedBox(height: 16),
            Divider(),
            Text('Attachments', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Column(
              children: email.attachments.map((att) {
                return ListTile(
                  leading: Icon(getIcon(att.mimeType), color: Colors.grey[700]),
                  title: Text(att.fileName),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_new),
                    onPressed: () => openAttachment(att),
                  ),
                );
              }).toList(),
            ),
          ],

          // Footer links for LinkedIn/Facebook (Unsubscribe, etc.)
          if ((isLinkedIn || isFacebook) && footerLinks.isNotEmpty) ...[
            SizedBox(height: 16),
            Divider(),
            Text('Links:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...footerLinks.map((link) {
              return TextButton(
                onPressed: () {
                  // Use url_launcher to open link['url']
                  print('Open link: ${link['url']}');
                },
                child: Text(link['text']!),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }
}
