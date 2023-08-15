

class Surgery {
  String id;
  String patient;
  String? provider;
  String type;
  String? other;
  DateTime date;
  String description;
  String? anesthesia;
  String? outcome;
  List<String>? files;
  List<String>? sharedWith;

  Surgery({
    required this.id,
    required this.patient,
    required this.type,
    required this.date,
    required this.description,
    this.provider,
    this.anesthesia,
    this.files,
    this.other,
    this.outcome,
    this.sharedWith,
  });

  factory Surgery.fromJson(Map<String, dynamic> json) {
    List<String>? sharedWith =
        json['sharedWith'] != null ? List<String>.from(json['sharedWith']) : [];
    List<String> files =
        json['files'] != null ? List<String>.from(json['files']) : [];
    return Surgery(
      date: DateTime.parse(json['date']),
      description: json['description'],
      id: json['_id'],
      patient: json['patient'],
      type: json['type'],
      provider: json['provider'] as String?,
      anesthesia: json['anesthesia'] as String?,
      other: json['other'] as String?,
      outcome: json['outcome'],
      sharedWith: sharedWith,
      files: files,
    );
  }
}
