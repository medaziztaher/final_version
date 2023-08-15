import 'package:get/get.dart';

class DoctorNavigationController extends GetxController {
  int _currentPage = 0;
  int _currentPatientePage = 0;
  int _currentHomePage = 0;
  int _currentChatPage = 0;

  int _previousHomePage = 0;
  int _previousDoctorPage = 0;

  int get currentPage => _currentPage;
  int get currentDoctorPage => _currentPatientePage;
  int get currentHomePage => _currentHomePage;
  int get currentChatPage => _currentChatPage;

  int get previousHomePage => _previousHomePage;
  int get previousDoctorPage => _previousDoctorPage;

  void updateCurrentPage(int index) {
    _currentPage = index;
    update();
  }

  void updateCurrentDoctorPage(int index) {
    _currentPatientePage = index;
    update();
  }

  void updatePreviousDoctorPage(int index) {
    _previousHomePage = index;
    update();
  }

  void updateCurrentHomePage(int index) {
    _currentHomePage = index;
    update();
  }

  void updatePreviousHomePage(int index) {
    _previousHomePage = index;
    update();
  }

  void updateCurrentChatPage(int index) {
    _currentChatPage = index;
    update();
  }
}
