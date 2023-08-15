import 'package:get/get.dart';
import 'package:medilink_app/models/user.dart';

class DoctorProfileController extends GetxController {
  late User _doctor;

  bool isConnected = true;
  bool isPending = false;

  User get doctor => _doctor;

  void selectDoctor(User doctor) {
    print(doctor);
    _doctor = doctor;
  }

  void connectWithDoctor() {
    isPending = true;
  }
}
