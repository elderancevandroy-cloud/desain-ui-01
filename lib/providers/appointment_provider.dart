import 'package:flutter/foundation.dart';
import '../models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  final List<AppointmentModel> _appointments = [];

  List<AppointmentModel> get appointments => List.unmodifiable(_appointments);

  void addBooking(AppointmentModel appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }
}
