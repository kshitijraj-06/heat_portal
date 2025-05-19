import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/email_service.dart';

class ComposeEmailScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  final _ccController = TextEditingController();
  final _bccController = TextEditingController();
  final EmailService _emailService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Email'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendEmail,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _toController,
                decoration: const InputDecoration(labelText: 'To'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ccController,
                decoration: const InputDecoration(labelText: 'CC'),
              ),
              TextFormField(
                controller: _bccController,
                decoration: const InputDecoration(labelText: 'BCC'),
              ),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(() => _emailService.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _sendEmail,
                child: const Text('Send Email'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _sendEmail() {
    if (_formKey.currentState!.validate()) {
      _emailService.sendEmail(
        to: _toController.text,
        subject: _subjectController.text,
        body: _bodyController.text,
        cc: _ccController.text.isNotEmpty ? _ccController.text : null,
        bcc: _bccController.text.isNotEmpty ? _bccController.text : null,
      );
    }
  }
}