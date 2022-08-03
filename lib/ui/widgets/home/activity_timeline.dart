import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityTimeLine extends StatelessWidget {
  ActivityTimeLine(
      {Key? key, required this.amount, required this.date, required this.name})
      : super(key: key);

  double amount;
  String name;
  String date;
  final double _thickness = 2.0;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.center,
      startChild: SizedBox(
        height: Get.height * 0.1,
        width: Get.width * 0.4,
        child: _incomeText(),
      ),
      indicatorStyle: IndicatorStyle(
          color: amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          height: 15.0,
          width: 15.0),
      beforeLineStyle: LineStyle(
          color: amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          thickness: _thickness),
      afterLineStyle: LineStyle(
          color: amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          thickness: _thickness),
      endChild: SizedBox(
        height: Get.height * 0.1,
        width: Get.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: AppKeysTextStyle.timeLineNameTextStyle),
            Text(date)
          ],
        ),
      ),
    );
  }

  Align _incomeText() {
    return Align(
      alignment: Alignment.center,
      child: Text(amount > 0 ? '+ $amount' : '$amount',
          style: amount > 0
              ? AppKeysTextStyle.currentBalanceStyle
              : AppKeysTextStyle.currentBalanceStyle
                  .copyWith(color: AppColors.silkenRuby)),
    );
  }
}
