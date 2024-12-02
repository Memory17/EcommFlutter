import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendMailScreen extends StatefulWidget {
  final String recipientEmail;

  SendMailScreen({required this.recipientEmail});

  @override
  _SendMailScreenState createState() => _SendMailScreenState();
}

class _SendMailScreenState extends State<SendMailScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // Hàm gửi email
  Future<void> _sendEmail() async {
    final String subject = _subjectController.text;
    final String body = _bodyController.text;
    final String recipient = widget.recipientEmail;

    final smtpServer = gmail('doanluc197@gmail.com', 'luclucoi'); // Thay đổi với thông tin của bạn

    final message = Message()
      ..from = Address('doanluc197@gmail.com') // Thay đổi email người gửi
      ..recipients.add(recipient)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email đã được gửi đến $recipient')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gửi email thất bại: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gửi Email'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Chủ đề'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Nội dung'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendEmail,
              child: Text('Gửi Email'),
            ),
          ],
        ),
      ),
    );
  }
}
