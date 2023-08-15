 import 'package:get/get.dart';

class PatientNavigationController extends GetxController {
  int _currentPage = 0;
  int _currentHomePage = 0;
  int _currentDoctorPage = 0;
  int _currentMedicalFolderPage = 0;
  int _currentChatPage = 0;
  int _currentProfilePage = 0;

  int _previousHomePage = 0;
  int _previousDoctorPage = 0;
  int _previousProfilePage = 0;

  int get currentPage => _currentPage;
  int get currentDoctorPage => _currentDoctorPage;
  int get currentHomePage => _currentHomePage;
  int get currentMedicalFolderPage => _currentMedicalFolderPage;
  int get currentChatPage => _currentChatPage;
  int get currentProfilePage => _currentProfilePage;

  int get previousHomePage => _previousHomePage;
  int get previousDoctorPage => _previousDoctorPage;
  int get previousProfilePage => _previousProfilePage;

  // previous page

  late int _previousPage;

  int get previousPage => _previousPage;

  void updatePreviousPage(int index) {
    _previousPage = index;
    update();
  }

  void updateCurrentPage(int index) {
    _currentPage = index;
    update();
  }

  void updateCurrentDoctorPage(int index) {
    _currentDoctorPage = index;
    update();
  }

  void updatePreviousDoctorPage(int index) {
    _previousHomePage = index;
    update();
  }

  void updateCurrentChatPage(int index) {
    _currentChatPage = index;
    update();
  }

  void updateCurrentHomePage(int index) {
    _currentHomePage = index;
    update();
  }

  void updateCurrentMedicalFolderPage(int index) {
    _currentHomePage = index;
    update();
  }

  void updateCurrentProfilePage(int index) {
    _currentProfilePage = index;
    update();
  }

  void updatePreviousHomePage(int index) {
    _previousHomePage = index;
    update();
  }

  void updatePreviousProfilePage(int index) {
    _previousProfilePage = index;
    update();
  }
}