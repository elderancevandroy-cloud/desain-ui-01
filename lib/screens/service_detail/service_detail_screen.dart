import 'package:flutter/material.dart';
import '../../models/service_model.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)?.settings.arguments as ServiceModel?;

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Layanan')),
        body: const Center(child: Text('Informasi layanan belum tersedia')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(service.name.replaceAll('\n', ' ')),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0077B6),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0077B6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name.replaceAll('\n', ' '),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (service.price.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      service.price,
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Deskripsi Layanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              service.description.isNotEmpty
                  ? service.description
                  : 'Informasi layanan belum tersedia',
              style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/book-appointment'),
                child: const Text('Book Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
