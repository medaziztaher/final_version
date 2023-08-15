import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/realtimelogic.dart';

class HomeData extends GetxController {
  late User _user = User(email: '', id: '', name: '', password: '', role: '');
  final RxList<User> users = <User>[].obs;
  final socket = SocketClient.instance.socket!;
  final SocketMethods _socket = SocketMethods();
  late HealthMetric healthMetric = HealthMetric(
      id: "",
      patient: "",
      metricName: "",
      value: 0,
      date: DateTime.now(),
      metricIcon: "",
      metricUnit: '');
  RxBool isLoading = false.obs;
  RxString errorMessage = 'No Error'.obs;
  final RxList<HealthMetric> healthMetrics = <HealthMetric>[].obs;

  NetworkHandler networkHandler = NetworkHandler();

  HomeData() {
    getHomeData();
  }

  @override
  void onInit() {
    super.onInit();
    _initialize();
    _socket.connectUser();
  }

  void _initialize() async {
    print(_user.role);
    if (_user.role == 'Patient') {
      await getHomeData();
      await getHealthcareMetrics();
    }
  }

  User get user => _user;
  List<HealthMetric> get listUserMetrics => healthMetrics;

  Future<void> getLastValue(String metricName) async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$metricUri/$metricName");
      if (response.statusCode == 200) {
        healthMetric =
            HealthMetric.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getHomeData() async {
    isLoading.value = true;
    String? userId = await getUserId();
    try {
      final response = await networkHandler.get("$userUri/$userId");
      if (json.decode(response.body)['status'] == true) {
        _user = User.fromJson(json.decode(response.body)['data']);
        update();
      } else {
        final data = json.decode(json.decode(response.body)['status']);
        errorMessage.value = data;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getHealthcareMetrics() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$metricUri/${_user.id}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final metrics =
            data.map((item) => HealthMetric.fromJson(item)).toList();
        healthMetrics.assignAll(metrics); // Use assignAll to update RxList
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
