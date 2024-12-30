// lib/features/inbox/inbox_controller.dart

import 'model.dart';

class InboxController {
  List<MessageModel> getMessages() {
    return [
      MessageModel(
        senderName: "Dr. Monsurul Alam",
        messagePreview: "I see. This could be due to various factors, like stress or even low iron. I’ll run a few tests to get a clearer picture",
        time: "Just Now",
        avatarUrl: "https://plus.unsplash.com/premium_photo-1658506671316-0b293df7c72b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9jdG9yfGVufDB8fDB8fHww",
        isRead: true,
      ),
      MessageModel(
        senderName: "Dr. Yaseen Chowdhury",
        messagePreview: "You: Yes, I’ve been sleeping, but I feel tired during the day, and sometimes I get a headache in the afternoon",
        time: "2 hours ago",
        avatarUrl: "https://images.unsplash.com/photo-1537368910025-700350fe46c7?crop=faces&fit=crop&w=200&h=200&q=80",
      ),
      MessageModel(
        senderName: "Dr. Farida parveen ",
        messagePreview: "Eion Morgan is a dedicated pediatrician...",
        time: "Yesterday",
        avatarUrl: "https://plus.unsplash.com/premium_photo-1682089872205-dbbae3e4ba32?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9jdG9yJTIwYmFuZ2xhfGVufDB8fDB8fHww",
        isRead: true,
      ),
      MessageModel(
        senderName: "Dr. GM patuary",
        messagePreview: "okay lets check",
        time: "Monday",
        avatarUrl: "https://images.unsplash.com/photo-1506812574058-fc75fa93fead?crop=faces&fit=crop&w=200&h=200&q=80",
      ),
      MessageModel(
        senderName: "Dr. Ariful Islam",
        messagePreview: "Not at all. Just keep an eye on the fever, and if it persists beyond five days, come back in for a follow-up.",
        time: "Saturday",
        avatarUrl: "https://plus.unsplash.com/premium_photo-1661745717091-488b4d4af658?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9jdG9yJTIwYmFuZ2xhfGVufDB8fDB8fHww",
      ),
      MessageModel(
        senderName: "Dr. Amal Kanti",
        messagePreview:"You: Hi, doctor. I have a sore throat, and I've been coughing a lot",
        time: "02 Oct",
        avatarUrl: "https://media.istockphoto.com/id/520709256/photo/portrait-of-a-handsome-asian-businessman.webp?a=1&b=1&s=612x612&w=0&k=20&c=54Hp_qTg1WR6nShW0dGUKmeywx3rIit09LGC_W8_-0Y=",
      ),
    ];
  }
}
