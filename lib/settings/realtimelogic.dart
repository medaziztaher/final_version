import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/settings/realtime.dart';

class SocketMethods extends GetxController {
  final _socket = SocketClient.instance.socket!;
  connectUser() async{
    _socket.emit("addUser", await globalUserId);
  }

  sendMessage(String senderId, String receiverId, String content) async {
    _socket.emit('sendMessage',
        {'senderId': senderId, 'receiverId': receiverId, 'content': content});
  }

  followUser(String senderId, String receiverId) async {
    Map<String, dynamic> data = {
      'senderId': senderId,
      'receiverId': receiverId,
    };
    _socket.emit('follow', data);
  }

  unfollowUser(String followedId, String followerId) async {
    Map<String, dynamic> data = {
      'followedId': followedId,
      'followerId': followerId,
    };
    _socket.emit('unfollow', data);
  }

  cancelRequest(String senderId, String receiverId) async {
    Map<String, dynamic> data = {
      'senderId': senderId,
      'receiverId': receiverId,
    };
    _socket.emit('cancelRequest', data);
  }

  approveRequest(String senderId, String receiverId) async {
    Map<String, dynamic> data = {
      'receiverId': senderId,
      'senderId': receiverId,
    };
    _socket.emit('approveRequest', data);
  }

  declineRequest(String senderId, String receiverId) async {
    Map<String, dynamic> data = {
      'senderId': senderId,
      'receiverId': receiverId,
    };
    _socket.emit('declineRequest', data);
  }
}
