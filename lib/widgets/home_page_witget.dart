// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taobao/constant_funcsion/choose_status.dart';
import 'package:taobao/constant_funcsion/hex_color.dart';
import 'package:taobao/constant_funcsion/trenumber.dart';
import 'package:taobao/object/item_object.dart';

class View1 extends StatelessWidget {
  const View1(
      {Key? key,
      required this.size,
      required this.item,
      required this.ontap,
      required this.ontapSlidable})
      : super(key: key);
  final Size size;
  final Item item;
  final Function ontap;
  final Function ontapSlidable;

  @override
  Widget build(BuildContext context) {
    File image = File(XFile(item.image).path);
    return Slidable(
      enabled: item.status == "Kutilmoqda" ? true : false,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Tasdiqlash',
            backgroundColor: Colors.green,
            autoClose: true,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            onPressed: (context) {
              ontapSlidable(true);
            },
          )
        ],
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Bekor qilish',
            backgroundColor: Colors.red,
            autoClose: true,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            onPressed: (context) {
              ontapSlidable(false);
            },
          )
        ],
      ),
      child: Container(
        height: size.height * 0.21,
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: ColorHex.colorFromHex("#FFFFFF"),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.name),
                subtitle: Text(item.productName),
                trailing: IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () {
                      ontap(item);
                    },
                    icon: SvgPicture.asset(
                      "assets/images/close.svg",
                      color: Colors.black,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Status.getStatus(item.status),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Statusi:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  item.status,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Summasi:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      TreeNumber.toProcessCost(item.price) + " so'm",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Sanasi:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      item.date,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
