// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/services.dart';

class AndroidCall {
  ///通讯名称,回到手机桌面
  static const String chanel = "example/call/android";

  //返回手机桌面事件
  static const String eventBackDesktop = "backDesktop";

  ///设置回退到手机桌面
  static Future backDesktop() async {
    if (Platform.isAndroid) {
      const platform = MethodChannel(chanel);
      try {
        await platform.invokeMethod(eventBackDesktop);
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }
  }
}
