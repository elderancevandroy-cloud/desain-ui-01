import 'package:flutter/foundation.dart';
import '../models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  int _responseIndex = 0;
  List<String> _responses = [];
  bool _initialized = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get initialized => _initialized;

  void initialize(String welcomeMessage, List<String> responses) {
    if (_initialized) return;
    _responses = responses;
    _messages.add(ChatMessage(text: welcomeMessage, isUser: false, time: DateTime.now()));
    _initialized = true;
    notifyListeners();
  }

  void sendMessage(String text) {
    _messages.add(ChatMessage(text: text, isUser: true, time: DateTime.now()));
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      if (_responses.isNotEmpty) {
        final response = _responses[_responseIndex % _responses.length];
        _responseIndex++;
        _messages.add(ChatMessage(text: response, isUser: false, time: DateTime.now()));
        notifyListeners();
      }
    });
  }
}
