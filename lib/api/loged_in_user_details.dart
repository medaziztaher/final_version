import 'dart:convert';

import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

NetworkHandler networkHandler = NetworkHandler();

Future<String?> queryUserRole() async {
  final response = await networkHandler.get(userUri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final user = User.fromJson(data['data']);
    return user.role;
  } else {
    return null;
  }
}

Future<String?> queryHealthcareProvdierType() async {
  final response = await networkHandler.get(userUri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final user = User.fromJson(data['data']);
    return user.type;
  } else {
    return null;
  }
}

Future<String?> queryUserID() async {
  final response = await networkHandler.get(userUri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final user = User.fromJson(data['data']);
    return user.id;
  } else {
    return null;
  }
}

Future<void> pushDeviceToken() async {
  Map<String, String> data = {'token': globalDeviceToken!};
  try {
    await networkHandler.put("$userUri/$globalUserId/device-token", data);
    return;
  } catch (e) {
    return;
  }
}
