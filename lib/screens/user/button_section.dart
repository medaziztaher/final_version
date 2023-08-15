import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/chat/screens/chat_screen.dart';


class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key, 
    required this.message,
    required this.onFollow,
    required this.onUnfollow,
    required this.onCancelRequest,
    required this.userId,
    required this.phoneNumber,
    required this.onApprove,
    required this.onDecline,
  });

  final String? message;
  final VoidCallback onFollow;
  final VoidCallback onUnfollow;
  final VoidCallback onCancelRequest;
  final VoidCallback onApprove;
  final VoidCallback onDecline;
  final String userId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    if (message == "followed") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 151, 198, 226)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Are you sure you want\n to unfollow this doctor'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onUnfollow();
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Unfollow'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 151, 198, 226),
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () => FlutterPhoneDirectCaller.callNumber(phoneNumber),
              child: const Icon(
                Icons.call,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 151, 198, 226),
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () => Get.to(() => ChatScreen(convId: userId)),
              child: const Icon(
                CupertinoIcons.chat_bubble_text_fill,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      );
    } else if (message ==
        "you have already sent an invitation to this account") {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirmation'),
                content: const Text(
                    'Are you sure you want\n to cancel the request?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancelRequest();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(
          'requested',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (message == "this account sent you an invitation") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: onApprove,
              child: const Text('Approve'),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: onDecline,
              child: const Text('Decline'),
            ),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: onFollow,
        child: const Text('Follow'),
      );
    }
  }
}
