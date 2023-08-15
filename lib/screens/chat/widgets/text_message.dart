/*import 'package:flutter/material.dart';
import 'package:medilink_client/models/message.dart';
import 'package:medilink_client/utils/constatnts.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
    required this.isSender,
  }) : super(key: key);

  final ChatMessage? message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 16 * 0.75,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.content,
        style: TextStyle(
          fontSize: 16,
          color: isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
*/