import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/input_controller.dart';

class PeriodGridView extends StatelessWidget {
  const PeriodGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: Get.height * 0.1 / 2),
        children: [
          _timePeriodGrid('30 gün'),
          _timePeriodGrid('60 gün'),
          _timePeriodGrid('90 gün'),
          _timePeriodGrid('1 hafta'),
          _timePeriodGrid('2 hafta'),
          _timePeriodGrid('24 saat'),
        ],
      ),
    );
  }

  GetBuilder _timePeriodGrid(String text) {
    return GetBuilder<InputController>(builder: (input) {
      return Container(
        //height: Get.height * 0.01,
        width: Get.width / 2,
        decoration: BoxDecoration(
            color: input.choosenTimePeriod == text
                ? Colors.blue.shade100
                : Colors.transparent),
        child: Center(
            child: TextButton(
                onPressed: () {
                  input.setChoosenTimePeriod(text);
                  if(input.tempAmount != null) input.updatePeriod(input.tempAmount!.copy(isFixed: true, period: text));
                },
                child: Text(text))),
      );
    });
  }
}
