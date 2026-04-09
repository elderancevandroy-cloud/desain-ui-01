class MessageModel {
  final int id;
  final String title;
  final String preview;
  final String date;
  final String content;

  MessageModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.date,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      preview: json['preview'] ?? '',
      date: json['date'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
