import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class MessageDetailScreen extends StatelessWidget {
  final MessageModel message;

  const MessageDetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0077B6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message.date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Divider(height: 24),
            Text(
              message.content,
              style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
