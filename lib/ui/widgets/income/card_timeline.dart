import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CardTimeLine extends StatelessWidget {
  CardTimeLine({Key? key, required this.amount}) : super(key: key);

  Amount amount;
  double _thickness = 1.0;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      indicatorStyle: IndicatorStyle(
          padding: const EdgeInsets.all(4.0),
          color: amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          height: 30.0,
          width: 30.0,
          iconStyle: IconStyle(
              iconData: amount.amount >= 0
                  ? Icons.insert_emoticon
                  : Icons.sentiment_dissatisfied_outlined,
              color: Colors.black,
              fontSize: amount.isFixed ? 25 : 0)),
      beforeLineStyle: LineStyle(
          color: amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          thickness: _thickness),
      afterLineStyle: LineStyle(
          color: amount.amount > 0 ? AppColors.limonana : AppColors.silkenRuby,
          thickness: _thickness),
      endChild: SizedBox(
        height: Get.height * 0.1,
        width: Get.width,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(amount.category),
            _profitText(),
          ],
        )),
      ),
    );
  }

  Text _profitText() {
    return Text(
        amount.amount >= 0
            ? '+${amount.amount.toString()}'
            : amount.amount.toString(),
        style: amount.amount >= 0
            ? AppKeysTextStyle.currentBalanceStyle
            : AppKeysTextStyle.currentBalanceStyle
                .copyWith(color: AppColors.silkenRuby));
  }
}
