class AppointmentModel {
  final String serviceName;
  final String date;
  final String timeSlot;
  final String userName;

  AppointmentModel({
    required this.serviceName,
    required this.date,
    required this.timeSlot,
    required this.userName,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      serviceName: json['service_name'] ?? '',
      date: json['date'] ?? '',
      timeSlot: json['time_slot'] ?? '',
      userName: json['user_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_name': serviceName,
      'date': date,
      'time_slot': timeSlot,
      'user_name': userName,
    };
  }
}
