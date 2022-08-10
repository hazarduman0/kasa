import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthComparisonCard extends StatelessWidget {
  const MonthComparisonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.21,
      width: Get.width * 0.8,
      child: const Card(
        child: Center(
          child: BarChart(
            
          ),
        ),
      ),
    );
  }
}