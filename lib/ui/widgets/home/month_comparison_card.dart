import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';

class MonthComparisonCard extends StatelessWidget {
  const MonthComparisonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmountController>(builder: (amount) {
      return SizedBox(
        height: Get.height * 0.21,
        width: Get.width * 0.8,
        child: Card(
          child: Center(
            child: !amount.pieLoad
                ? SizedBox(
                    height: Get.height * 0.21,
                    width: Get.width * 0.8,
                    child: PieChart(
                    swapAnimationCurve: Curves.easeIn,
                    swapAnimationDuration: const Duration(seconds: 5),
                      PieChartData(
                        sections: amount.getSections,
                      )
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}
