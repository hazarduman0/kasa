import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartController extends GetxController {
 final RxList<charts.Series> _simpleChartseriesList = <charts.Series>[].obs;

 List<charts.Series> get simpleChartSeriesList => _simpleChartseriesList.value; 
}

class SimpleChart{
  final String amountName;
  final double amount;

  SimpleChart(this.amountName, this.amount);
  
}