import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_model.dart';
import '../../providers/appointment_provider.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String serviceName;
  final String date;
  final String timeSlot;
  final String userName;
  final VoidCallback? onBookingConfirmed;

  const BookingConfirmationScreen({
    super.key,
    required this.serviceName,
    required this.date,
    required this.timeSlot,
    required this.userName,
    this.onBookingConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Booking'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0077B6),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Pemesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _SummaryRow(label: 'Layanan', value: serviceName),
            _SummaryRow(label: 'Tanggal', value: date),
            _SummaryRow(label: 'Waktu', value: timeSlot),
            _SummaryRow(label: 'Nama', value: userName),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final appointment = AppointmentModel(
                    serviceName: serviceName,
                    date: date,
                    timeSlot: timeSlot,
                    userName: userName,
                  );
                  context
                      .read<AppointmentProvider>()
                      .addBooking(appointment);

                  // Pop back to MainScaffold, then switch to Health tab (index 3)
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                  onBookingConfirmed?.call();
                },
                child: const Text('Konfirmasi Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const Text(': ', style: TextStyle(color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
