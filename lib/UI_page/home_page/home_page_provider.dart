// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taobao/object/item_object.dart';

class HomePageProvider extends ChangeNotifier {
  bool appbar = true;
  double product = 0;
  double benefit = 0;
  dynamic select;
  String search = "";
  final searchController = TextEditingController();
  static var box = Hive.box("MyBaza");
  List<Item> items = [];
  apbarrSearch(value) {
    appbar = value;
    search = "";
    searchController.text = "";
    getItem();
    notifyListeners();
  }

  status() {
    box.put("status", null);
  }

  getItem() async {
    var json = await box.get("items");
    var status = await box.get("status");
    if (json != null) {
      var respons = jsonDecode(json);
      items.clear();
      product = 0;
      benefit = 0;
      select = status;
      List<Item> allitems =
          List<Item>.from(respons.map((model) => Item.fromJson(model)));
      List<Item> setSearch = [];
      if (status != null) {
        for (var item in allitems) {
          if (item.status == status) {
            setSearch.add(item);
          }
        }
      } else {
        setSearch = allitems;
      }

      if (search.isEmpty) {
        items = setSearch;
      } else {
        for (var item in setSearch) {
          int length = item.name.length < search.length
              ? item.name.length
              : search.length;
          if (search == item.name.substring(0, length)) {
            items.add(item);
          }
        }
      }

      for (var item in items) {
        if (item.status == "Kutilmoqda") {
          product += double.parse(item.price);
        }
        if (item.status == "Tasdiqlangan") {
          benefit += double.parse(item.price);
        }
      }
    }
    notifyListeners();
  }

  itemdelete(context, Item itemdelete) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: "Ma'lumotni o'chirish",
        desc:
            itemdelete.name + "ning maxsulotini rostdan ham o'chirmoqchimisiz?",
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          items.removeWhere((item) => item.id == itemdelete.id);
          box.put("items", jsonEncode(items));
          getItem();
        },
        btnOkText: "HA",
        btnCancelText: "YO'Q")
      ..show();
  }

  setStatus(value, Item itemStatus, context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.topSlide,
        title: value ? "Tovarni tasdiqlash" : "Tovarni bekor qilish",
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          for (int i = 0; i < items.length; i++) {
            if (items[i].id == itemStatus.id) {
              if (value) {
                items[i].status = "Tasdiqlangan";
              } else {
                items[i].status = "Bekor qilingan";
              }
              break;
            }
          }
          box.put("items", jsonEncode(items));
          getItem();
        },
        btnOkText: "SAQLASH",
        btnCancelText: "BEKOR QILISH")
      ..show();
  }

  searchList(searchValue) {
    search = searchValue;
    getItem();
  }
}
