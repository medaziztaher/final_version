/*import 'package:flutter/material.dart';
import 'package:medilink_client/models/message.dart';
import 'package:medilink_client/screens/chat/widgets/text_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final ChatMessage message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey[50],
              backgroundImage: const AssetImage(
                "assets/images/doctor.png",
              ),
            ),
            const SizedBox(width: 16 / 2),
          ],
          TextMessage(isSender: isSender),
        ],
      ),
    );
  }
}
*/