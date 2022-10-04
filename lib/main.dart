import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

import 'UI_page/home_page/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("MyBaza");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
