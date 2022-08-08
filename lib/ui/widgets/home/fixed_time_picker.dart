// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:kasa/controllers/input_controller.dart';
// import 'package:kasa/core/constrants/app_keys.dart';
// import 'package:kasa/core/constrants/app_keys_textstyle.dart';

// class FixedTimePicker extends StatelessWidget {
//   const FixedTimePicker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<InputController>(builder: (input) {
//       return AnimatedContainer(
//         //height: input.isFixed ? Get.height * 0.15 : Get.height * 0.1,
//         width: Get.width,
//         constraints: BoxConstraints(minHeight: Get.height * 0.1),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//           color: Colors.white,
//         ),
//         duration: const Duration(milliseconds: 150),
//         child: !input.isFixed
//             ? Center(child: _checkboxListTile())
//             : Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _checkboxListTile(),
//                     const Divider(),
//                     _selectPeriodText(),
//                     _setTimePeriod(),
//                     const Divider(),
//                     // input.isValidTimePeriod
//                     //     ? const SizedBox.shrink()
//                     //     : const Text('Lütfen 0 dan büyük bir değer giriniz',
//                     //         style: TextStyle(color: Colors.red))
//                     _lasPeriodDateText(),
//                     _lastPeriodDate(),
//                   ],
//                 ),
//               ),
//       );
//     });
//   }

//   GetBuilder _checkboxListTile() {
//     return GetBuilder<InputController>(builder: (input) {
//       return CheckboxListTile(
//         title: const Text('Sabit'),
//         //subtitle: input.isFixed ? const Text('Tekrar Periyodu') : const SizedBox.shrink(),
//         value: input.isFixed,
//         onChanged: (value) {
//           input.setIsFixed(value!);
//         },
//       );
//     });
//   }

//   Padding _selectPeriodText() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
//       child: Text('${AppKeys.frequencyRecurrence}:'),
//     );
//   }

//    //0 girilme durumlarını, dispose olduğundaki durumlarını ayarla ve sayı dışında değer girilmesini engelle.
//   //periyot kısmına girilecek maxlength i ayarla, altta değer gözükmesin
//   Padding _setTimePeriod() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//           height: Get.height * 0.1,
//           width: Get.width,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.05,
//                     width: Get.width * 0.15,
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       // validator: (value) {
//                       //   if (value != null) {
//                       //     if (int.tryParse(value)! < 0) {
//                       //       // Get.snackbar('Yanlış Değer',
//                       //       //     'Lütfen 0 dan büyük bir değer giriniz');
//                       //       inputController.setValidTimePeriod(false);
//                       //       //return '';
//                       //     }
//                       //   } else {
//                       //     inputController.setValidTimePeriod(true);
//                       //   }
//                       // },
//                       //validasyon yerine gereksiz tuşlara basmasını engelle
//                       onChanged: (value) {
//                         inputController.setDayPeriod(value);
//                       },
//                       // onSaved: (newValue) {
//                       //   inputController.setDayPeriod(newValue);
//                       // },
//                     ),
//                   ),
//                   SizedBox(width: Get.width * 0.01),
//                   Text(AppKeys.dayText,
//                       style: AppKeysTextStyle.timePeriodTextStyle),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.05,
//                     width: Get.width * 0.15,
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       // validator: (value) {
//                       //   snackBarWarn(value);
//                       // },
//                       //validasyon yerine gereksiz tuşlara basmasını engelle
//                       onChanged: (value) {
//                         inputController.setHourPeriod(value);
//                       },
//                       // onSaved: (newValue) {
//                       //   inputController.setHourPeriod(newValue);
//                       // },
//                     ),
//                   ),
//                   SizedBox(width: Get.width * 0.01),
//                   Text(AppKeys.hourText,
//                       style: AppKeysTextStyle.timePeriodTextStyle),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.05,
//                     width: Get.width * 0.15,
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       // validator: (value) {
//                       //   snackBarWarn(value);
//                       // },
//                       //validasyon yerine gereksiz tuşlara basmasını engelle
//                       onChanged: (value) {
//                         inputController.setMinutePeriod(value);
//                       },
//                       // onSaved: (newValue) {
//                       //   inputController.setMinutePeriod(newValue);
//                       // },
//                     ),
//                   ),
//                   SizedBox(width: Get.width * 0.01),
//                   Text(AppKeys.minuteText,
//                       style: AppKeysTextStyle.timePeriodTextStyle),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }

//   Padding _lasPeriodDateText() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
//       child: Text('${AppKeys.lastPeriodDate}:'),
//     );
//   }

//   SizedBox _lastPeriodDate() {
//     return SizedBox(
//       height: Get.height * 0.25,
//       width: Get.width,
//       child: CupertinoDatePicker(
//         mode: CupertinoDatePickerMode.date,
//         minimumYear: DateTime.now().year,
//         //minimumDate: DateTime.now(),
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (value) {
//           print('dateTime: $value');
//           //inputController.setLastPeriodDate(value); //her seferinde çalıştığında akıcılığı bozuyor.
//           tempDateTime =
//               value; //save kısmında gerekli kontrolleri yaptıktan sonra controllere aktar.
//         },
//       ),
//     );
//   }
// }