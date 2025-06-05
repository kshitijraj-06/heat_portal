import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher_string.dart';

class EmailService extends GetxController {
  // final _clientId = '564406745968-s8d05l88e8a08ku83rem536bf3pkkgl5.apps.googleusercontent.com';
  // final _clientSecret = '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';
  // Use full-mail scope to allow read, modify, delete, star, move, etc.
  final _scopes = [
    'https://mail.google.com/'
  ];

  final isLoading = false.obs;
  final error = RxnString();
  final emails = <Map<String, dynamic>>[].obs;
  final labels = <Map<String, String>>[].obs;

  AuthClient? _authClient;

  /// One-time OAuth consent combining all Gmail permissions under mail.google.com
  Future<void> ensureClient() async {
    if (_authClient != null) return;
    final id = ClientId(_clientId, _clientSecret);
    _authClient = await clientViaUserConsent(
      id,
      _scopes,
          (authUrl) async {
        await launchUrlString(authUrl, mode: LaunchMode.externalApplication);
      },
    );
  }

  /// Fetch available labels for the user (Inbox, Sent, custom, etc.)
  Future<void> loadLabels() async {
    try {
      await ensureClient();
      final token = _authClient!.credentials.accessToken.data;
      final res = await http.get(
        Uri.parse('http://localhost:5000/labels'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode != 200) {
        throw Exception('Labels error ${res.statusCode}: ${res.body}');
      }
      final data = jsonDecode(res.body) as Map;
      final List labs = data['labels'] as List;
      // Map id and name
      labels.assignAll(labs.map((l) => {'id': l['id'], 'name': l['name']}).cast<Map<String, String>>());
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> loadEmails() async {
    isLoading.value = true;
    error.value = null;
    try {
      await ensureClient();
      final token = _authClient!.credentials.accessToken.data; // Get the token string

      print("Sending token: $token"); // Debug print

      final res = await http.post(
        Uri.parse('http://localhost:5000/emails'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'access_token': token, // Send as raw string
          'max_results': 20      // Add required field
        }),
      );

      if (res.statusCode != 200) {
        throw Exception('Server error ${res.statusCode}: ${res.body}');
      }

      final data = jsonDecode(res.body) as Map;
      emails.assignAll((data['emails'] as List).cast<Map<String, dynamic>>());

    } catch (e) {
      error.value = 'Failed to load emails: ${e.toString()}';
      print("Error details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
    String? cc,
    String? bcc,
  }) async {
    try {
      isLoading.value = true;
      error.value = null;

      await ensureClient();
      final token = _authClient!.credentials.accessToken.data;

      final response = await http.post(
        Uri.parse('http://localhost:5000/emails/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'to': to,
          'subject': subject,
          'body': body,
          if (cc != null) 'cc': cc,
          if (bcc != null) 'bcc': bcc,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send email: ${response.body}');
      }

      Get.snackbar('Success', 'Email sent successfully');

    } catch (e) {
      error.value = 'Failed to send email: ${e.toString()}';
      Get.snackbar('Error', 'Failed to send email',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _modifyLabels(String id, List<String> add, List<String> remove) async {
    await ensureClient();
    final token = _authClient!.credentials.accessToken.data;
    final res = await http.post(
      Uri.parse('http://localhost:5000/emails/modify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'access_token': token,
        'id': id,
        'addLabelIds': add,
        'removeLabelIds': remove,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('Modify labels failed ${res.statusCode}: ${res.body}');
    }
  }

  /// Move email to a folder/label by removing default ones and adding target
  Future<void> moveEmail(String id, String targetLabelId) async {
    try {
      // Common labels: INBOX, SENT, TRASH, SPAM
      var remove = ['INBOX'];
      await _modifyLabels(id, [targetLabelId], remove);
      // Update local
      emails.removeWhere((msg) => msg['id'] == id);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> deleteEmail(String id) async {
    try {
      await ensureClient();
      final token = _authClient!.credentials.accessToken.data;
      final res = await http.post(
        Uri.parse('http://localhost:5000/emails/delete'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'access_token': token, 'id': id}),
      );
      if (res.statusCode != 200) {
        throw Exception('Delete failed ${res.statusCode}: ${res.body}');
      }
      emails.removeWhere((msg) => msg['id'] == id);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> starEmail(String id) async {
    try {
      await _modifyLabels(id, ['STARRED'], []);
      final idx = emails.indexWhere((msg) => msg['id'] == id);
      if (idx != -1) emails[idx]['starred'] = true;
      emails.refresh();
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> unstarEmail(String id) async {
    try {
      await _modifyLabels(id, [], ['STARRED']);
      final idx = emails.indexWhere((msg) => msg['id'] == id);
      if (idx != -1) emails[idx]['starred'] = false;
      emails.refresh();
    } catch (e) {
      error.value = e.toString();
    }
  }
}
