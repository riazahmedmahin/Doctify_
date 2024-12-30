// lib/features/inbox/presentation/widgets/message_item.dart

import 'package:app/message/avatarawidgets.dart';
import 'package:flutter/material.dart';

import 'model.dart';


class MessageItem extends StatelessWidget {
  final MessageModel message;

  const MessageItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(imageUrl: message.avatarUrl),
      title: Text(
        message.senderName,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800]),
      ),
      subtitle: Text(
        message.messagePreview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message.time,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          if (message.isRead)
            Icon(Icons.check_circle, color: Colors.green, size: 18),
        ],
      ),
    );
  }
}
