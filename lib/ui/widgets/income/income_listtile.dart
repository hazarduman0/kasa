import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/ui/screens/amount_detail.dart';

class IncomeListTile extends StatelessWidget {
  IncomeListTile({Key? key, required this.amount}) : super(key: key);

  Amount amount;

  final InputController inputController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width,
      child: ListTile(
        leading: _profitText(),
        title: Text(amount.category),
        subtitle: Text(amount.description),
        trailing: const Icon(Icons.arrow_forward_ios_outlined,
            color: Colors.black, size: 15.0),
        onTap: () {
          inputController.setCategoryText(amount.category);
          amount.amount > 0
              ? inputController.isRemoveFunc(false)
              : inputController.isRemoveFunc(true);
          inputController.setTempAmount(amount);
          Get.to(() => AmountDetailPage());
        },
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
                .copyWith(fontSize: Get.width * 0.05)
            : AppKeysTextStyle.currentBalanceStyle.copyWith(
                color: AppColors.silkenRuby, fontSize: Get.width * 0.05));
  }
}
