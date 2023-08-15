import 'package:medilink_app/api/paths.dart';

class Notifications {
  String id;
  String? recipient;
  String? senderPic;
  String? notificationType;
  String? content;
  String? payload;
  bool? isRead;
  DateTime? createdDate;
  Notifications({
    required this.id,
    this.payload,
    this.recipient,
    this.senderPic,
    this.notificationType,
    this.content,
    this.isRead,
    this.createdDate,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    String? userPic = json['senderPic'];
    userPic = userPic != null ? "$profilePicPath/$userPic" : "";
    return Notifications(
      id: json['_id'],
      recipient: json['recipient'],
      senderPic: userPic,
      notificationType: json['notificationType'],
      content: json['content'],
      payload: json['payload'],
      isRead: json['isRead'],
      createdDate: DateTime.parse(json['createdAt']),
    );
  }
}
