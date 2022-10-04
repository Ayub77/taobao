// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taobao/constant_funcsion/hex_color.dart';

Future modalBottomSheetMenu(BuildContext context, Size size, select) {
  var box = Hive.box("MyBaza");
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: size.height * 0.6,
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 5,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: ColorHex.colorFromHex("#8896A1")),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Saralash",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 15),
                      DropdownSearch(
                        mode: Mode.MENU,
                        showSelectedItems: false,
                        items: ["Kutilmoqda", "Tasdiqlangan", 'Bekor qilingan'],
                        selectedItem: select,
                        dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 17),
                            hintText: "Statusni tanlang",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorHex.colorFromHex("#A3A3A3")),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorHex.colorFromHex("#8896A1"),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorHex.colorFromHex("#8896A1"),
                                ))),
                        onChanged: (value) {
                          box.put("status", value);
                        },
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorHex.colorFromHex("#8896A1"),
                                width: 1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Davr boshlanishi",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorHex.colorFromHex("#A3A3A3")),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/images/calendar.svg",
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorHex.colorFromHex("#8896A1"),
                                width: 1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Davr yakunlanishi",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorHex.colorFromHex("#A3A3A3")),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/images/calendar.svg",
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          height: 50,
                          child: OutlineButton(
                              onPressed: () {
                                box.put("status", null);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "BEKOR QILISH",
                                style: TextStyle(
                                    color: ColorHex.colorFromHex("#FF4842"),
                                    fontSize: 16),
                              ),
                              borderSide: BorderSide(
                                  color: ColorHex.colorFromHex("#FF4842")),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ButtonTheme(
                          height: 50,
                          child: OutlineButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "SAQLASH",
                                style: TextStyle(
                                    color: ColorHex.colorFromHex("#44B71C"),
                                    fontSize: 16),
                              ),
                              borderSide: BorderSide(
                                  color: ColorHex.colorFromHex("#44B71C")),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
      });
}
