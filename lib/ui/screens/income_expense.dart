import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/income_expense_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/ui/screens/fixed_expenses.dart';
import 'package:kasa/ui/screens/fixed_incomes.dart';
import 'package:kasa/ui/widgets/income/card_timeline.dart';

class IncomeExpensePage extends StatelessWidget {
  const IncomeExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03, vertical: Get.height * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _fixedIncomeCard(),
                SizedBox(height: Get.height * 0.05),
                _fixedExpenseCard(),
                SizedBox(height: Get.height * 0.05),
                /////
              ],
            ),
          ),
        ),
      ),
    );
  }

  GetBuilder _fixedIncomeCard() {
    return GetBuilder<IncomeExpenseController>(builder: (incomeExpense) {
      return SizedBox(
        height: Get.height * 0.45,
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(AppKeys.fixedIncomeCardText,
                        style: AppKeysTextStyle.cardHeaderTextStyle),
                    SizedBox(width: Get.width * 0.02),
                    Icon(Icons.push_pin_outlined,
                        color: AppColors.maximumBlueGreen, size: 25.0)
                  ],
                ),
                const Divider(),
                SizedBox(height: Get.height * 0.04),
                Expanded(
                  flex: 5,
                  child: incomeExpense.fixedIncomeList.isEmpty
                      ? const Center(child: Text('Burası boş'))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: incomeExpense.fixedIncomeList.length < 4
                              ? incomeExpense.fixedIncomeList.length
                              : 4,
                          itemBuilder: (context, index) {
                            return CardTimeLine(
                                amount: incomeExpense.fixedIncomeList[index]);
                          },
                        ),
                ),
                incomeExpense.fixedIncomeList.length > 3 ? Expanded(
                  flex: 1,
                    child: Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const FixedIncomes());
                    },
                    child: const Text('Daha fazla'),
                  ),
                )) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }

  GetBuilder _fixedExpenseCard() {
    return GetBuilder<IncomeExpenseController>(builder: (incomeExpense) {
      return SizedBox(
        height: Get.height * 0.45,
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(AppKeys.fixedExpenseCardText,
                        style: AppKeysTextStyle.cardHeaderTextStyle),
                    SizedBox(width: Get.width * 0.02),
                    Icon(Icons.push_pin_outlined,
                        color: AppColors.maximumBlueGreen, size: 25.0)
                  ],
                ),
                const Divider(),
                SizedBox(height: Get.height * 0.04),
                Expanded(
                  flex: 5,
                  child: incomeExpense.fixedIncomeList.isEmpty
                      ? const Center(child: Text('Burası boş'))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: incomeExpense.fixedExpenseList.length < 3
                              ? incomeExpense.fixedExpenseList.length
                              : 3,
                          itemBuilder: (context, index) {
                            return CardTimeLine(
                                amount: incomeExpense.fixedExpenseList[index]);
                          },
                        ),
                ),
                incomeExpense.fixedExpenseList.length > 3 ? Expanded(
                  flex: 1,
                    child: Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const FixedExpenses());
                    },
                    child: const Text('Daha fazla'),
                  ),
                )) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _appBarBuild() {
    return AppBar(
      elevation: 0.0,
      title: Text(AppKeys.appBarIncomeExpenseText,
          style: AppKeysTextStyle.incomeExpenseAppBarTextStyle),
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black)),
    );
  }
}
