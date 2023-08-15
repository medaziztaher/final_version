import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/screens/complete_profile/components/doctorcompletprofile/doctor_form.dart';
import 'package:medilink_app/screens/complete_profile/components/patientcommpletform/patient_form.dart';
import 'package:medilink_app/screens/complete_profile/components/providercompletprofile/provider_form.dart';

class CompleteProfileScreen extends StatefulWidget { // Change to StatefulWidget
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late String globalRole = ''; // Initialize with an empty string
  String? globalType;

  @override
  void initState() {
    super.initState();
    fetchUserRoles(); // Call the function to fetch user roles when the widget initializes
  }

  Future<void> fetchUserRoles() async { // Asynchronous function
    globalRole = (await getUserRole())!;
    if (globalRole == 'HealthcareProvider') {
      globalType = await getUserType();
    }
    setState(() {}); // Update the widget after fetching roles
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: globalRole == 'Patient'
          ? const PatienForm()
          : globalType == 'Doctor'
              ? const DoctorForm()
              : const ProviderForm(),
    );
  }
}
