import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/income_expense_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/ui/screens/income_expense.dart';
import 'package:kasa/ui/widgets/home/activity_timeline.dart';
import 'package:kasa/ui/widgets/home/bottom_sheet_widget.dart';
import 'package:kasa/ui/widgets/home/month_comparison_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AmountController _amount = Get.find();

  final IncomeExpenseController _incomeExpense = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: Get.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: Get.height * 0.2,
                child: const Align(
                  alignment: Alignment.center,
                  child: MonthComparisonCard(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: Get.height - 150),
              child: Card(
                margin: EdgeInsets.zero,
                color: AppColors.bakeryBox,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.04),
                    child: GetBuilder<AmountController>(builder: (amount) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedCrossFade(
                            firstChild: _rangeAndProfit(),
                            secondChild: _rangeOptions(),
                            crossFadeState: !amount.rangeCrossFadeBool
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            firstCurve: Curves.easeOut,
                            secondCurve: Curves.easeIn,
                          ),

                          amount.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : getAmountWidgetList().isNotEmpty
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: getAmountWidgetList() +
                                          [SizedBox(height: Get.height * 0.1)],
                                    )
                                  : Container(
                                      height: Get.height / 2,
                                      width: Get.width,
                                      alignment: Alignment.center,
                                      child: const Text(
                                          'Burada bir işlem \ngörünmüyor',
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(elevation: 0.0, items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.rotate_left_outlined),
            label: 'Son İşlemler',
            backgroundColor: AppColors.maximumBlueGreen),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () async {
                await _incomeExpense.getFixedExpenseList();
                await _incomeExpense.getFixedIncomeList();
                await _incomeExpense.getRegularExpenseList();
                await _incomeExpense.getRegularIncomeList();
                Get.to(() => IncomeExpensePage());
              },
              icon: const Icon(Icons.my_library_books_outlined)),
          label: '${AppKeys.incomeText}/${AppKeys.expense}',
          backgroundColor: AppColors.maximumBlueGreen,
        ),
        BottomNavigationBarItem(
          icon: GetBuilder<InputController>(builder: (sheet) {
            return IconButton(
              onPressed: () {
                sheet.isRemoveFunc(false);

                _getBottomSheet();
              },
              icon: Icon(Icons.add_circle_outlined,
                  color: AppColors.limonana, size: 35.0),
            );
          }),
          label: '',
        ),
      ]),
      floatingActionButton: GetBuilder<InputController>(builder: (sheet) {
        return FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            sheet.isRemoveFunc(true);
            _getBottomSheet();
          },
          backgroundColor: AppColors.silkenRuby,
          child: const Icon(Icons.remove_outlined, size: 25.0),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Container _rangeOptions() {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          _rangeOption('Son 12 saat'),
          _rangeOption('Son 24 saat'),
          _rangeOption('Son hafta'),
          _rangeOption('Son 15 gün'),
          _rangeOption('Son 30 gün'),
          _rangeOption('Son 60 gün'),
          _rangeOption('Son 90 gün'),
          _rangeOption('Özel')
        ],
      ),
    );
  }

  TextButton _rangeOption(/*Function? func,*/ String string) => TextButton(
      onPressed: () {
        _amount.setSelectedRange(string);
        _amount.getAmountList();
        _amount.setRangeCrossFadeBool(false);
      },
      child: Text(string,
          style: TextStyle(
              color: _amount.selectedRange == string
                  ? AppColors.goldenLuck
                  : AppColors.maximumBlueGreen)));

  GetBuilder _rangeAndProfit() {
    return GetBuilder<AmountController>(builder: (amount) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                _amount.setRangeCrossFadeBool(true);
              },
              child: Text(amount.selectedRange,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(
              amount.netAmount >= 0
                  ? '+${amount.netAmount.toString()}'
                  : amount.netAmount.toString(),
              style: amount.netAmount >= 0
                  ? AppKeysTextStyle.currentBalanceStyle
                  : AppKeysTextStyle.currentBalanceStyle
                      .copyWith(color: AppColors.silkenRuby))
        ],
      );
    });
  }

  Future<dynamic> _getBottomSheet() {
    return Get.bottomSheet(
        elevation: 0.0,
        isScrollControlled: true,
        enableDrag: false,
        BottomSheetWidget());
  }

  List<Widget> getAmountWidgetList() {
    return List.generate(
        _amount.amountList.length,
        (index) => ActivityTimeLine(
              amount: _amount.amountList[index],
              isFirst: index == 0,
              isLast: index == _amount.amountList.length - 1,
            ));
  }
}
