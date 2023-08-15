import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/screens/home/home_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class MetricController extends GetxController {
  GlobalKey<FormState> formKeyMetric = GlobalKey<FormState>();
  bool isLoading = false;
  final valueController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  late Metric metric;
  MetricController({required this.metric});

  @override
  void onClose() {
    valueController.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    isLoading = true;
    Map<String, String> data = {
      'metricName': metric.healthMetric.toString(),
      'metricUnit': metric.unit.toString(),
      'value': valueController.text,
    };
    try {
      if (formKeyMetric.currentState!.validate()) {
        final response = await networkHandler.post(metricUri, data);
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 201) {
          Get.snackbar(
              metric.healthMetric, "New value added successfully");
          Get.off(() => const HomeScreen());
          valueController.clear();
        }
      } else {
        Get.snackbar(metric.healthMetric, "Failed to add health metric");
      }
    } catch (e) {
      print(e);
      isLoading = false;
    } finally {
      isLoading = false;
    }
  }
}
