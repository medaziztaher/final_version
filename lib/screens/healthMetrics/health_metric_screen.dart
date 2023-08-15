import 'package:flutter/material.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/screens/healthMetrics/components/metri_form.dart';

class MetricScreen extends StatelessWidget {
  const MetricScreen({super.key, required this.metric});
  final Metric metric;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MetricForm(metric: metric),
    );
  }
}
