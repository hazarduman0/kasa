import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/income_expense_controller.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/ui/widgets/income/income_listtile.dart';

class FixedExpenses extends StatelessWidget {
  const FixedExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Tüm Sabit Giderler', style: AppKeysTextStyle.incomeExpenseAppBarTextStyle.copyWith(fontSize: Get.width * 0.05),),
                SizedBox(height: Get.height * 0.05),
                GetBuilder<IncomeExpenseController>(
                  builder: (incomeExpense) {
                    return SizedBox(
                      height: Get.height * 0.8,
                      width: Get.width,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: incomeExpense.fixedExpenseList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            IncomeListTile(amount: incomeExpense.fixedExpenseList[index]),
                            const Divider(),
                          ],
                        );
                      },));
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBarBuild() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black)),
    );
  }
  }
