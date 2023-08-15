import 'package:medilink_app/api/paths.dart';

class ConversationDetails {
  final String id;
  final String name;
  final String picture;
  final ConversationOther other;
  final String lastMessage;

  ConversationDetails({
    required this.id,
    required this.name,
    required this.picture,
    required this.other,
    required this.lastMessage,
  });

  factory ConversationDetails.fromJson(Map<String, dynamic> json) {
    String? userPic =
        json['user'] != null ? json['user']['picture'] as String? : null;
    userPic = userPic != null ? "$profilePicPath/$userPic" : "";
    return ConversationDetails(
      id: json['id'],
      name: json['name'],
      picture: userPic,
      other: ConversationOther.fromJson(json['other']),
      lastMessage: json['lastMessage'],
    );
  }
}

class ConversationOther {
  final String id;
  final DateTime updatedAt;
  final List<String> members;

  ConversationOther({
    required this.id,
    required this.updatedAt,
    required this.members,
  });

  factory ConversationOther.fromJson(Map<String, dynamic> json) {
    return ConversationOther(
      id: json['_id'],
      updatedAt: DateTime.parse(json['updatedAt']),
      members: List<String>.from(json['members']),
    );
  }
}
