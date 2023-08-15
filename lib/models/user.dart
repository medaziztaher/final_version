import 'package:medilink_app/api/paths.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String role;
  String? address;
  String? phoneNumber;
  String? picture;
  String? gender;
  String? socketId;
  String? deviceToken;
  bool? connected;
  bool? verified;
  int? age;
  List<String>? invitations;
  String? status;
  String? type;
  String? firstname;
  String? lastname;
  String? speciality;
  List<String>? patients;
  String? description;
  List<String>? buildingpictures;
  String? licenseVerificationCode;
  DateTime? dateOfBirth;
  String? civilState;
  int? numberOfChildren;
  String? occupation;
  bool? smokingStatus;
  int? numberOfCigarettesPerDay;
  bool? alcoholism;
  int? frequencyOfDrinksPerWeek;
  String? bloodGroup;
  String? rhFactor;
  List<String>? preferredLanguage;
  List<String>? prescriptions;
  List<String>? emergencyContacts;
  List<String>? allergies;
  List<String>? diseases;
  List<String>? healthcareMetrics;
  List<String>? radiographies;
  List<String>? surgeries;
  List<String>? laboratoryResults;
  List<Map<String, Object?>>? healthcareProviders;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.address,
    this.phoneNumber,
    this.picture,
    this.gender,
    this.socketId,
    this.deviceToken,
    this.connected = false,
    this.verified = false,
    this.invitations,
    this.status,
    this.type,
    this.firstname,
    this.lastname,
    this.speciality,
    this.patients,
    this.description,
    this.buildingpictures,
    this.licenseVerificationCode,
    this.dateOfBirth,
    this.civilState,
    this.numberOfChildren,
    this.occupation,
    this.smokingStatus,
    this.numberOfCigarettesPerDay,
    this.alcoholism,
    this.frequencyOfDrinksPerWeek,
    this.bloodGroup,
    this.rhFactor,
    this.preferredLanguage,
    this.prescriptions,
    this.emergencyContacts,
    this.allergies,
    this.diseases,
    this.healthcareMetrics,
    this.radiographies,
    this.surgeries,
    this.laboratoryResults,
    this.healthcareProviders,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<String>? invitations = json['invitations'] != null
        ? List<String>.from(json['invitations'])
        : [];
    List<String>? patients =
        json['patients'] != null ? List<String>.from(json['patients']) : [];
    List<String>? preferredLanguage = json['preferredLanguage'] != null
        ? List<String>.from(json['preferredLanguage'])
        : [];
    List<String>? prescriptions = json['prescriptions'] != null
        ? List<String>.from(json['prescriptions'])
        : [];
    List<String>? emergencyContacts = json['emergencyContacts'] != null
        ? List<String>.from(json['emergencyContacts'])
        : [];
    List<String>? allergies =
        json['allergies'] != null ? List<String>.from(json['allergies']) : [];
    List<String>? diseases =
        json['diseases'] != null ? List<String>.from(json['diseases']) : [];
    List<String>? healthcareMetrics = json['healthcareMetrics'] != null
        ? List<String>.from(json['healthcareMetrics'])
        : [];
    List<String>? radiographies = json['radiographies'] != null
        ? List<String>.from(json['radiographies'])
        : [];
    List<String>? surgeries =
        json['surgeries'] != null ? List<String>.from(json['surgeries']) : [];
    List<String>? laboratoryResults = json['laboratoryResults'] != null
        ? List<String>.from(json['laboratoryResults'])
        : [];
    List<Map<String, Object?>>? healthcareProviders =
        json['healthcareProviders'] != null
            ? (json['healthcareProviders'] as List<dynamic>).map((item) {
                return {
                  'healthcareproviderId': item['patientId'],
                  'type': item['type'] ?? "",
                  'speciality': item['speciality'] ?? ""
                };
              }).toList()
            : [];
    String? userPic = json['picture'];
    userPic = userPic != null ? "$profilePicPath/$userPic" : "";
    List<String>? buildingpictures = json['buildingpictures'] != null
        ? (json['buildingpictures'] as List<dynamic>).map((item) {
            String url = "$buildingpicsPath/${item['url']}";
            return url;
          }).toList()
        : [];
    return User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        gender: json['gender'],
        role: json['role'],
        address: json['address'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        picture: userPic,
        socketId: json['socketId'] as String?,
        deviceToken: json['deviceToken'] as String?,
        connected: json['connected'] as bool?,
        verified: json['verified'] as bool?,
        invitations: invitations,
        status: json['status'] as String?,
        type: json['type'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        speciality: json['speciality'] as String?,
        patients: patients,
        description: json['description'] as String?,
        buildingpictures: buildingpictures,
        licenseVerificationCode: json['licenseVerificationCode'] as String?,
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.parse(json['dateOfBirth'])
            : null,
        civilState: json['civilState'] as String?,
        numberOfChildren: json['numberOfChildren'] as int?,
        occupation: json['occupation'] as String?,
        smokingStatus: json['smokingStatus'] as bool?,
        numberOfCigarettesPerDay: json['numberOfCigarettesPerDay'] as int?,
        alcoholism: json['alcoholism'] as bool?,
        frequencyOfDrinksPerWeek: json['frequencyOfDrinksPerWeek'] as int?,
        bloodGroup: json['bloodGroup'] as String?,
        rhFactor: json['rhFactor'] as String?,
        preferredLanguage: preferredLanguage,
        prescriptions: prescriptions,
        emergencyContacts: emergencyContacts,
        allergies: allergies,
        diseases: diseases,
        healthcareMetrics: healthcareMetrics,
        radiographies: radiographies,
        surgeries: surgeries,
        laboratoryResults: laboratoryResults,
        healthcareProviders: healthcareProviders,
        age: json['age']);
  }
}
