import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/ui/screens/amount_detail.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityTimeLine extends StatelessWidget {
  ActivityTimeLine(
      {Key? key,
      required this.amount,
      this.isFirst = false,
      this.isLast = false})
      : super(key: key);

  Amount amount;
  // double amount;
  // String name;
  // String date;
  bool isLast;
  bool isFirst;
  final double _thickness = 1.0;

  final InputController inputController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        inputController.setCategoryText(amount.category);
        amount.amount > 0
            ? inputController.isRemoveFunc(false)
            : inputController.isRemoveFunc(true);
        Get.to(() => AmountDetailPage(amount: amount));
      },
      child: TimelineTile(
        alignment: TimelineAlign.center,
        isLast: isLast,
        isFirst: isFirst,
        startChild: SizedBox(
          height: Get.height * 0.1,
          width: Get.width * 0.4,
          child: _incomeText(),
        ),
        indicatorStyle: IndicatorStyle(
            padding: const EdgeInsets.all(4.0),
            color:
                amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
            height: 10.0,
            width: 10.0),
        beforeLineStyle: LineStyle(
            color:
                amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
            thickness: _thickness),
        afterLineStyle: LineStyle(
            color:
                amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
            thickness: _thickness),
        endChild: SizedBox(
          height: Get.height * 0.1,
          width: Get.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(amount.category,
                  style: AppKeysTextStyle.timeLineNameTextStyle),
              Text(DateFormat.yMd().format(amount.dateTime))
            ],
          ),
        ),
      ),
    );
  }

  Align _incomeText() {
    return Align(
      alignment: Alignment.center,
      child: Text(amount.amount > 0 ? '+ ${amount.amount}' : '${amount.amount}',
          style: amount.amount > 0
              ? AppKeysTextStyle.currentBalanceStyle
              : AppKeysTextStyle.currentBalanceStyle
                  .copyWith(color: AppColors.silkenRuby)),
    );
  }
}
