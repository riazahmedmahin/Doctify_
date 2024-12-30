// lib/features/inbox/data/models/message_model.dart

class MessageModel {
  final String senderName;
  final String messagePreview;
  final String time;
  final String avatarUrl;
  final bool isRead;

  MessageModel({
    required this.senderName,
    required this.messagePreview,
    required this.time,
    required this.avatarUrl,
    this.isRead = false,
  });
}
