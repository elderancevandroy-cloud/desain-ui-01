import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/banner_model.dart';
import '../models/service_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class MockData {
  static Future<List<BannerModel>> loadBanners() async {
    final String jsonString = await rootBundle.loadString('assets/data/banners.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => BannerModel.fromJson(e)).toList();
  }

  static Future<List<ServiceModel>> loadServices() async {
    final String jsonString = await rootBundle.loadString('assets/data/services.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => ServiceModel.fromJson(e)).toList();
  }

  static Future<List<String>> loadAppointmentSlots() async {
    final String jsonString = await rootBundle.loadString('assets/data/appointment_slots.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> slots = jsonMap['slots'] ?? [];
    return slots.cast<String>();
  }

  static Future<List<MessageModel>> loadMessages() async {
    final String jsonString = await rootBundle.loadString('assets/data/messages.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => MessageModel.fromJson(e)).toList();
  }

  static Future<Map<String, dynamic>> loadChatResponses() async {
    final String jsonString = await rootBundle.loadString('assets/data/chat_responses.json');
    return json.decode(jsonString);
  }

  static Future<UserModel> loadUser() async {
    final String jsonString = await rootBundle.loadString('assets/data/user.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return UserModel.fromJson(jsonMap);
  }
}
