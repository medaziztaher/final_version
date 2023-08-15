import 'package:medilink_app/api/paths.dart';

class EmergencyContact {
  String id;
  String patient;
  String? picture;
  String name;
  String phoneNumber;
  String relationship;

  EmergencyContact(
      {required this.id,
      required this.patient,
      required this.name,
      required this.phoneNumber,
      required this.relationship,
      this.picture});

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    String? userPic = json['picture'];
    userPic = userPic != null ? "$emergencyContactPath/$userPic" : "";
    return EmergencyContact(
        id: json['_id'],
        patient: json['patient'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        relationship: json['relationship'],
        picture: userPic);
  }
}
