import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

NetworkHandler networkHandler = NetworkHandler();
Future<List<Map<String, dynamic>>> fetchHealthMetrics(
    String patientId, String metricName) async {
  final url = '$metricUri/$patientId/$metricName';

  final response = await networkHandler.get(url);
  print("response : $response");
  if (json.decode(response.body)['status'] == true) {
    final jsonData = json.decode(response.body)['data'];
    print("jsonData : $jsonData");
    return List<Map<String, dynamic>>.from(jsonData);
  } else {
    throw Exception('Failed to fetch health metrics');
  }
}

List<double> extractValues(List<Map<String, dynamic>> healthMetrics) {
  return healthMetrics
      .map<double>((metric) => metric['value'].toDouble())
      .toList();
}

List<DateTime> extractDates(List<Map<String, dynamic>> healthMetrics) {
  return healthMetrics
      .map<DateTime>((metric) => DateTime.parse(metric['date']))
      .toList();
}

List<ChartSampleData> createMetricSeries(
    List<Map<String, dynamic>> healthMetrics) {
  final metricData = healthMetrics.map((metric) {
    final date = DateTime.parse(metric['date']);
    final value = metric['value'].toDouble();
    return ChartSampleData(x: date, y: value);
  }).toList();

  return metricData;
}

class ChartSampleData {
  final DateTime x;
  final double y;

  ChartSampleData({required this.x, required this.y});
}

class MetricCurveChart extends StatefulWidget {
  final String patientId;
  final String metricName;

  MetricCurveChart({required this.patientId, required this.metricName});

  @override
  _MetricCurveChartState createState() => _MetricCurveChartState();
}

class _MetricCurveChartState extends State<MetricCurveChart> {
  late Future<List<Map<String, dynamic>>> _fetchHealthMetricsFuture;

  @override
  void initState() {
    super.initState();
    _fetchHealthMetrics();
  }

  Future<void> _fetchHealthMetrics() async {
    try {
      _fetchHealthMetricsFuture = fetchHealthMetrics(
        widget.patientId,
        widget.metricName,
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchHealthMetricsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to fetch health metrics'),
          );
        } else if (snapshot.hasData) {
          final healthMetrics = snapshot.data!;
          final seriesData = createMetricSeries(healthMetrics);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(16.0),
              scaleEnabled: true,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                series: <ChartSeries<ChartSampleData, DateTime>>[
                  LineSeries<ChartSampleData, DateTime>(
                    dataSource: seriesData,
                    xValueMapper: (ChartSampleData metric, _) => metric.x,
                    yValueMapper: (ChartSampleData metric, _) => metric.y,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}
