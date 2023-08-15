
class Radiographie {
  String id;
  String patient;
  String? provider;
  String type;
  String description;
  DateTime date;
  String? location;
  String reason;
  List<String>? files;
  List<String>? sharedWith;

  Radiographie({
    required this.id,
    required this.patient,
    required this.description,
    required this.type,
    required this.date,
    required this.reason,
    this.provider,
    this.files,
    this.location,
    this.sharedWith,
  });

  factory Radiographie.fromJson(Map<String, dynamic> json) {
    List<String>? sharedWith =
        json['sharedWith'] != null ? List<String>.from(json['sharedWith']) : [];
     List<String> files =
        json['files'] != null ? List<String>.from(json['files']) : [];
    return Radiographie(
      id: json['_id'],
      patient: json['patient'],
      provider: json['provider'] as String?,
      type: json['type'],
      reason: json['reason'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json["location"],
      files: files,
      sharedWith: sharedWith,
    );
  }
}
