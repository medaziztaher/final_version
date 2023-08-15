import 'package:flutter/material.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/utils/constants.dart';

class MetricsCard extends StatefulWidget {
  const MetricsCard({super.key, required this.index, required this.item});

  final int index;
  final Metric item;

  @override
  State<MetricsCard> createState() => _MetricsCardState();
}

class _MetricsCardState extends State<MetricsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.index == 0 ? 0 : defaultListViewItemsPadding,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        height: 122,
        width: 130,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.item.healthMetric.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: typingColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(96, 171, 182, 234),
                          blurRadius: 30.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Image.asset(
                      widget.item.icon.toString(),
                      color: widget.item.theme,
                      width: 26,
                    ),
                  ),
                ],
              ),
              Text(
                widget.item.unit.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: darkGreyColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
