class ChatMessage {
  String? id;
  String? conversationId;
  String sender;
  String receiver;
  DateTime? date;
  String content;

  ChatMessage(
      {this.conversationId,
      this.id,
      required this.sender,
      required this.receiver,
      this.date,
      required this.content});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        conversationId: json['conversationId'],
        id: json['_id'],
        sender: json['sender'],
        receiver: json['receiver'],
        date: DateTime.parse(json['createdAt'] as String),
        content: json['content']);
  }
}
