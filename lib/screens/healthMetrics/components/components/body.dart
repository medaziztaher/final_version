import 'package:flutter/material.dart';
import 'package:medilink_app/components/metric_card.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/healthMetrics/components/metric_curv_chart.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  NetworkHandler networkHandler = NetworkHandler();
  List<Metric> metrics = health; // Using the static list of metrics
  List<bool> showChartList = List.generate(health.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              child: ListView.builder(
                itemCount: health.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = health[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        showChartList[index] = !showChartList[index];
                      });
                    },
                    child: MetricsCard(
                      index: index,
                      item: item,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'MetricCurveChart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: metrics.map((metric) {
                final index = metrics.indexOf(metric);
                if (showChartList[index]) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                        child: MetricCurveChart(
                          patientId: widget.user.id,
                          metricName: metric.healthMetric,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
