import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

final pref = Pref();
//global variables :
String? globalToken = getToken();
Future<String?> globalRole = getUserRole();
Future<String?> globalType = getUserType();
Future<String?> globalUserId = getUserId();
String? globalDeviceToken;

//global functions :
void setGlobaldeviceToken(String? notificationtoken) {
  globalDeviceToken = notificationtoken;
}

String? getToken() {
  return pref.prefs!.getString(kTokenSave);
}

String? getUuid() {
  return pref.prefs!.getString(kuuid);
}

Future<String?> getUserId() async {
  return await queryUserID();
}

Future<String?> getUserRole() async {
  return await queryUserRole();
}

Future<String?> getUserType() async {
  return await queryHealthcareProvdierType();
}
