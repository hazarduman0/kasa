import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kasa/bindings/await_bindings.dart';
import 'package:kasa/ui/screens/home_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await AwaitBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(elevation: 0.0)
      ),
      home: HomePage(),
    );
  }
}
