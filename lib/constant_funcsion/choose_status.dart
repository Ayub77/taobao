import 'package:flutter/cupertino.dart';
import 'package:taobao/constant_funcsion/hex_color.dart';

class Status {
  static Color getStatus(status) {
    switch (status) {
      case "Kutilmoqda":
        return ColorHex.colorFromHex("#FFA801");
      case "Bekor qilingan":
        return ColorHex.colorFromHex("#FF4842");
      case "Tasdiqlangan":
        return ColorHex.colorFromHex("#44B71C");
    }
    return ColorHex.colorFromHex("#A3A3A3");
  }
}
