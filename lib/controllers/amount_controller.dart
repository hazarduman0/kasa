import 'package:get/get.dart';
import 'package:kasa/core/utils.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class AmountController extends GetxController {
  AmountOperations amountOperations = AmountOperations();

  final RxList<Amount> _amountList = <Amount>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _selectedRange = 'Son 15 gün'.obs;
  final RxBool _rangeCrossFadeBool = false.obs;
  final RxDouble _netAmount = 0.0.obs;

  List<Amount> get amountList => _amountList;
  String get selectedRange => _selectedRange.value;
  double get netAmount => _netAmount.value;
  
  bool get isLoading => _isLoading.value;
  bool get rangeCrossFadeBool => _rangeCrossFadeBool.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAmountListc();
    getAmountList();
    
    //print('deneme: ${amountOperations.deneme()}');
  }

  

  getAmountListc() async {
  
    List<Amount> amountResponse = await amountOperations.getAmountList();
    for(var amount in amountResponse){
      print(amount.dateTime);
    }
    
  }

  getAmountList() async {
    String now = '${DateTime.now()}';
    String input =
        '${(DateTime.now()).subtract(Utils.timeAgoFunc(_selectedRange.value))}';

    String timeago = '${input.substring(0, 10)}T${input.substring(11)}';
    String currentTime = '${now.substring(0, 10)}T${now.substring(11)}}';
    _isLoading.value = true;
    update();
    List<Amount> amountResponse = await amountOperations.getDesignatedList(
        timeago: timeago, date: currentTime);
    setNetAmount(amountResponse);
    _amountList.value = amountResponse;
    _isLoading.value = false;
    update();
  }

  setNetAmount(List<Amount> amountList) {
    double net = 0.0;
    for (var amount in amountList) {
      net = net + (amount.amount);
    }
    _netAmount.value = net;
    update();
  }

  

  // getAmountList() async {
  //   _isLoading.value = true;
  //   update();
  //   List<Amount> amountResponse = await amountOperations.getAmountList();
  //   _amountList.value = amountResponse;
  //   _isLoading.value = false;
  //   update();
  // }

  setSelectedRange(String range) {
    _selectedRange.value = range;
    update();
  }

  setRangeCrossFadeBool(bool crossFadeBool) {
    _rangeCrossFadeBool.value = crossFadeBool;
    update();
  }
}
