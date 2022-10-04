// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_single_cascade_in_expression_statements, await_only_futures

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taobao/UI_page/add_page/add_page.dart';
import 'package:taobao/UI_page/home_page/home_page_provider.dart';
import 'package:taobao/constant_funcsion/choose_status.dart';
import 'package:taobao/constant_funcsion/hex_color.dart';
import 'package:taobao/constant_funcsion/trenumber.dart';
import 'package:taobao/object/item_object.dart';
import 'package:taobao/widgets/bottomsheet.dart';
import 'package:taobao/widgets/home_page_witget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageProvider provider = HomePageProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.status();
    provider.getItem();
  }

  Future<bool> onWillPop() async {
    bool canExit = false;
    AwesomeDialog dlg = AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: 'Dasturdan chiqish',
        desc: 'Dasturdan chiqishni hohlaysizmi?',
        dismissOnBackKeyPress: false,
        useRootNavigator: true,
        dismissOnTouchOutside: true,
        btnCancelOnPress: () => canExit = false,
        btnOkOnPress: () => canExit = true,
        btnOkText: "CHIQISH",
        btnCancelText: "BEKOR QILISH");

    await dlg.show();
    return Future.value(canExit);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<HomePageProvider>(
        builder: (context, value, child) => WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            backgroundColor: ColorHex.colorFromHex("#E5E5E5"),
            appBar: provider.appbar
                ? AppBar(
                    foregroundColor: ColorHex.colorFromHex("#FFFFFF"),
                    backgroundColor: ColorHex.colorFromHex("#8896A1"),
                    title: Text("Narxlar"),
                    elevation: 0.5,
                    actions: [
                      IconButton(
                          onPressed: () {
                            provider.apbarrSearch(false);
                          },
                          icon: SvgPicture.asset("assets/images/search.svg")),
                      IconButton(
                          onPressed: () {
                            modalBottomSheetMenu(context, size, provider.select)
                                .then((value) {
                              provider.getItem();
                            });
                          },
                          icon: SvgPicture.asset("assets/images/filter.svg")),
                      SizedBox(
                        width: 7,
                      )
                    ],
                  )
                : AppBar(
                    leadingWidth: 0,
                    leading: Container(),
                    backgroundColor: ColorHex.colorFromHex("#8896A1"),
                    title: Container(
                      decoration: BoxDecoration(
                          color: ColorHex.colorFromHex("#FFFFFF"),
                          borderRadius: BorderRadius.circular(5)),
                      width: double.infinity,
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                provider.apbarrSearch(true);
                              },
                              icon: SvgPicture.asset(
                                "assets/images/left.svg",
                              )),
                          Expanded(
                            child: TextField(
                              controller: provider.searchController,
                              onChanged: (value) {
                                provider.searchList(value);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Qanday ma’lumot izlayabsiz?",
                                  hintStyle: TextStyle(
                                      fontFamily: "SFProDisplay",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                provider.apbarrSearch(false);
                              },
                              icon: SvgPicture.asset(
                                "assets/images/closeX.svg",
                                color: ColorHex.colorFromHex("#8896A1"),
                              )),
                        ],
                      ),
                    ),
                  ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: size.height * 0.07),
                  child: provider.items.isEmpty
                      ? Center(
                          child: Text("Ma'lumotlar yo'q"),
                        )
                      : ListView.builder(
                          itemCount: provider.items.length,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          itemBuilder: (context, index) {
                            return View1(
                              size: size,
                              item: provider.items[index],
                              ontap: (value) {
                                provider.itemdelete(context, value);
                              },
                              ontapSlidable: (value) {
                                provider.setStatus(
                                    value, provider.items[index], context);
                              },
                            );
                          },
                        ),
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    height: size.height * 0.07,
                    width: size.width,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          color: ColorHex.colorFromHex("#8896A1"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Qabul qilingan summa:",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                TreeNumber.toProcessCost(
                                        provider.benefit.toString()) +
                                    " so'm",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Buyurtma summasi:",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                TreeNumber.toProcessCost(
                                        provider.product.toString()) +
                                    " so'm",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddPage()))
                    .then((value) {
                  provider.getItem();
                });
              },
              child: Icon(Icons.add),
              backgroundColor: ColorHex.colorFromHex("#8896A1"),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }

  Widget view(Item item, size) {
    File image = File(XFile(item.image).path);
    int radian = 0;
    return InkWell(
      onTap: () {
        if (radian == 0) {
          radian = 180;
        } else {
          radian = 0;
        }
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        transform: Matrix4.identity()
          ..setEntry(2, 3, 0.001)
          ..rotateX(radian * 3.1415927 / 180),
        height: size.height * 0.25,
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
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
                      provider.itemdelete(context, item);
                    },
                    icon: SvgPicture.asset(
                      "assets/images/close.svg",
                      color: Colors.black,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Status.getStatus(item.status),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buyurtma statusi:",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          item.status,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Muddati:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "15 kun",
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
