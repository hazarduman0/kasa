import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/ui/widgets/home/activity_timeline.dart';
import 'package:kasa/ui/widgets/home/bottom_sheet_widget.dart';
import 'package:kasa/ui/widgets/home/month_comparison_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AmountController _amount = Get.find();

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
                //color: Colors.red,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Son 30 gün'),
                              Text('+4.342,02',
                                  style: AppKeysTextStyle.currentBalanceStyle)
                            ],
                          ),
                          amount.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  //listviewBuilder
                                  mainAxisSize: MainAxisSize.min,
                                  children: getAmountWidgetList() +
                                      [SizedBox(height: Get.height * 0.1)],
                                )
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
            icon: const Icon(Icons.incomplete_circle_outlined),
            label: '${AppKeys.incomeText}/${AppKeys.expense}',
            backgroundColor: AppColors.maximumBlueGreen),
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
          //backgroundColor: AppColors.maximumBlueGreen,
        ),
      ]),
      floatingActionButton: GetBuilder<InputController>(builder: (sheet) {
        return FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            sheet.isRemoveFunc(true);
            _getBottomSheet();
          },
          child: Icon(Icons.remove_outlined, size: 25.0),
          backgroundColor: AppColors.silkenRuby,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
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



// ActivityTimeLine(
//                               amount: -500,
//                               date: '24/07/2022',
//                               name: 'Faturalar'),
//                           ActivityTimeLine(
//                               amount: -400,
//                               date: '25/07/2022',
//                               name: 'Online Alışveriş'),
//                           ActivityTimeLine(
//                               amount: -800,
//                               date: '27/07/2022',
//                               name: 'Mutfak Alışverişi'),
//                           ActivityTimeLine(
//                               amount: -2000, date: '28/07/2022', name: 'kira'),
//                           ActivityTimeLine(
//                               amount: 11000, date: '31/07/2022', name: 'Maaş')