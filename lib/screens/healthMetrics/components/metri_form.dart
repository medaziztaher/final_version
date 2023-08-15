import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/screens/healthMetrics/health_metric_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class MetricForm extends StatelessWidget {
  const MetricForm({Key? key, required this.metric}) : super(key: key);
  final Metric metric;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultScreenPadding,
            vertical: defaultScreenPadding,
          ),
          child: Column(
            children: [
              SizedBox(height: 3.h),
              Center(
                child: Column(
                  children: [
                    const Text("Add New ", style: headingStyle),
                    Text("${metric.healthMetric} value", style: headingStyle),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GetBuilder<MetricController>(
                  init: MetricController(metric: metric),
                  builder: (controller) {
                    return Form(
                      key: controller.formKeyMetric,
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          buildValueFormField(controller),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                              buttonText: 'kbutton1'.tr,
                              isLoading: false,
                              onPress: () {
                                controller.submitForm();
                              },
                            ),
                          ),
                          SizedBox(height: 3.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildValueFormField(MetricController controller) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => controller.valueController.text = newValue!,
      controller: controller.valueController,
      decoration: InputDecoration(
        labelText: metric.healthMetric.toString(),
        hintText: "Enter new ${metric.healthMetric.toString()} value",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
