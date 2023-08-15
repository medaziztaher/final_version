import 'package:medilink_app/api/paths.dart';

class Options {
  String id;
  String option;
  String name;
  String? icon;
  DateTime date;

  Options(
      {required this.id,
      this.icon,
      required this.name,
      required this.option,
      required this.date});

  factory Options.fromJson(Map<String, dynamic> json) {
    String? icon = json['icon'];
    icon = icon != null ? "$iconPath/$icon" : "";
    return Options(
        id: json['_id'],
        icon: icon,
        name: json['name'],
        option: json['option'],
        date: DateTime.parse(json['createdAt']));
  }
}
