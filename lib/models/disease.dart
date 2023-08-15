class Disease {
  String id;
  String patient;
  String diseaseName;
  String? speciality;
  String severity;
  bool genetic;
  bool chronicDisease;
  DateTime? detectedIn;
  DateTime? curedIn;
  String? symptoms;
  String? medications;
  bool familyHistory;
  bool recurrence;
  String? notes;

  Disease(
      {required this.id,
      required this.patient,
      required this.diseaseName,
      required this.severity,
      required this.genetic,
      required this.chronicDisease,
      required this.familyHistory,
      required this.recurrence,
      this.curedIn,
      required this.detectedIn,
      this.medications,
      this.notes,
      this.speciality,
      this.symptoms});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
        id: json['_id'],
        patient: json['patient'],
        diseaseName: json['diseaseName'],
        severity: json['severity'],
        genetic: json['genetic'],
        chronicDisease: json['chronicDisease'],
        familyHistory: json['familyHistory'],
        recurrence: json['recurrence'],
        symptoms: json['symptoms'],
        medications: json['medications'],
        curedIn:
            json['curedIn'] != null ? DateTime.parse(json['curedIn']) : null,
        detectedIn: DateTime.parse(json['detectedIn']),
        notes: json['notes'] as String?,
        speciality: json['speciality'] as String?);
  }
}
