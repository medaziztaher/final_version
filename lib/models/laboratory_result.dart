import 'package:medilink_app/api/paths.dart';

class LaboratoryResult {
  String id;
  String patient;
  String? provider;
  String testName;
  String result;
  String? units;
  String? referenceRange;
  bool abnormalFlag;
  DateTime date;
  String reason;
  List<String>? files;
  List<String>? sharedWith;

  LaboratoryResult(
      {required this.id,
      required this.patient,
      required this.testName,
      required this.result,
      required this.abnormalFlag,
      required this.date,
      required this.reason,
      this.provider,
      this.referenceRange,
      this.units,
      this.files,
      this.sharedWith});
  factory LaboratoryResult.fromJson(Map<String, dynamic> json) {
    List<String>? sharedWith =
        json['sharedWith'] != null ? List<String>.from(json['sharedWith']) : [];
    List<String> files = json['files'] != null
        ? (json['files'] as List<dynamic>).map((item) {
            String url =
                "$laboratoryResultPath/$item"; // Use 'item' instead of 'json['files']'
            return url;
          }).toList()
        : [];
    return LaboratoryResult(
        id: json['_id'] as String,
        patient: json['patient'] as String,
        testName: json['testName'],
        result: json['result'],
        abnormalFlag: json['abnormalFlag'],
        date: DateTime.parse(json['date']),
        reason: json['reason'],
        sharedWith: sharedWith,
        files: files,
        provider: json['provider'] as String?,
        referenceRange: json['referenceRange'],
        units: json['units']);
  }
}
