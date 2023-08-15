class Allergy {
  String id;
  String patient;
  String type;
  String severity;
  String? trigger;
  String? reaction;
  DateTime? yearOfDiscovery;
  String? onset;
  String? followupStatus;
  bool? familyHistory;
  String? notes;
  List<String>? treatment;

  Allergy(
      {required this.id,
      required this.patient,
      required this.type,
      required this.severity,
      this.trigger,
      this.reaction,
      required this.yearOfDiscovery,
      this.familyHistory,
      this.followupStatus,
      this.notes,
      this.onset,
      this.treatment});

  factory Allergy.fromJson(Map<String, dynamic> json) {
    List<String>? treatment =
        json['treatment'] != null ? List<String>.from(json['treatment']) : [];
    return Allergy(
        id: json['_id'],
        patient: json['patient'],
        type: json['type'],
        severity: json['severity'],
        trigger: json['trigger'] as String?,
        reaction: json['reaction'] as String?,
        yearOfDiscovery: DateTime.parse(json['yearOfDiscovery']),
        onset: json['onset'] as String?,
        followupStatus: json['followupStatus'] as String?,
        familyHistory: json['familyHistory'] as bool?,
        notes: json['notes'] as String?,
        treatment: treatment);
  }
}
