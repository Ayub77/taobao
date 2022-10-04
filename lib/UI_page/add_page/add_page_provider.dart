// ignore_for_file: unnecessary_null_comparison, prefer_final_fields

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class AddPageProvider extends ChangeNotifier {
  late File image;
  bool chek = false;
  final namecontroller = TextEditingController();

  final productnamecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  static var box = Hive.box("MyBaza");
  DateTime nowDate = DateTime.now();
  var items = [];
  setImage(bool choose, context) async {
    final ImagePicker _picker = ImagePicker();
    if (choose) {
      XFile? ximage = await _picker.pickImage(source: ImageSource.gallery);
      if (ximage != null) {
        image = File(ximage.path);
        chek = true;
      }
    } else {
      XFile? ximage = await _picker.pickImage(source: ImageSource.camera);
      if (ximage != null) {
        image = File(ximage.path);
        chek = true;
      }
    }
    Navigator.pop(context);
    notifyListeners();
  }

  saveInfo(context) async {
    String name = namecontroller.text.trim();
    String product = productnamecontroller.text.trim();
    String price = pricecontroller.text.trim();
    String year = nowDate.year.toString();
    String month = nowDate.month >= 10
        ? nowDate.month.toString()
        : "0" + nowDate.month.toString();
    String day = nowDate.day >= 10
        ? nowDate.day.toString()
        : "0" + nowDate.day.toString();
    String date = year + "." + month + "." + day;

    if (name.isEmpty || product.isEmpty || price.isEmpty || image == null) {
      EasyLoading.showInfo("Ma'lumotlarni to'ldiring!");
    } else {
      var respons = await box.get("items");
      if (respons == null) {
        Map<String, String> item = {
          "id": "1",
          "image": image.path,
          "name": name,
          "product": product,
          "status": "Kutilmoqda",
          "date": date,
          "price": price
        };
        items.add(item);
      } else {
        items = jsonDecode(respons);
        int id = int.parse(items[items.length - 1]["id"]) + 1;
        Map<String, String> item = {
          "id": id.toString(),
          "image": image.path,
          "name": name,
          "product": product,
          "status": "Kutilmoqda",
          "date": date,
          "price": price
        };
        items.add(item);
      }
      box.put("items", jsonEncode(items));
      EasyLoading.showSuccess("Muvofaqiyatli saqlandi!");
      Navigator.pop(context);
    }
  }
}
