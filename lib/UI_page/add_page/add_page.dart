// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taobao/UI_page/add_page/add_page_provider.dart';
import 'package:taobao/constant_funcsion/hex_color.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddPageProvider provider = AddPageProvider();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<AddPageProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: ColorHex.colorFromHex("#8896A1"),
            title: Text("Buyurtma yaratish"),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: size.height * 0.85,
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          showPicker();
                        },
                        child: Container(
                          height: 116,
                          width: 116,
                          decoration: BoxDecoration(
                            color: ColorHex.colorFromHex("#F5F5F5"),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: provider.chek
                              ? Image.file(
                                  provider.image,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/images/camera.svg",
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      view("Mijoz", "Ismini kiriting", provider.namecontroller,
                          false),
                      view("Tovar", "Nomini kiriting",
                          provider.productnamecontroller, false),
                      view("Narx", "Tovar narxini kiriting",
                          provider.pricecontroller, true),
                    ],
                  ),
                  ButtonTheme(
                    minWidth: size.width,
                    height: 55,
                    child: OutlineButton(
                        onPressed: () {
                          provider.saveInfo(context);
                        },
                        child: Text(
                          "SAQLASH",
                          style: TextStyle(
                              color: ColorHex.colorFromHex("#44B71C"),
                              fontSize: 16),
                        ),
                        borderSide:
                            BorderSide(color: ColorHex.colorFromHex("#44B71C")),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget view(label, hint, controller, choose) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: choose ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(color: ColorHex.colorFromHex("#8896A1")),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: ColorHex.colorFromHex("#8896A1"))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: ColorHex.colorFromHex("#8896A1"))),
        ),
      ),
    );
  }

  void showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  onTap: () {
                    provider.setImage(true, context);
                  },
                  title: Text("Galareya"),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  onTap: () {
                    provider.setImage(false, context);
                  },
                  title: Text("Camera"),
                )
              ],
            ),
          ));
        });
  }
}
