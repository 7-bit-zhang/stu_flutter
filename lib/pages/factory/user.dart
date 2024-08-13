// ignore_for_file: overridden_fields, deprecated_member_use

import 'package:flutter/material.dart';

class User {
  String name;
  String avatar;
  User({required this.name, required this.avatar});
  static User? _instance;

  static User? _getInstance() {
    _instance ??= User._internal();
    return _instance;
  }

  static User get instance => _getInstance()!;

  static User _internal() {
    return User(name: "张三", avatar: "123");
  }
}

class StText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextStyle defaultStyle;
  final int? maxLines;
  final TextAlign? align;
  @override
  final Key? key;

  const StText({
    required this.text,
    required this.defaultStyle,
    this.key,
    this.style,
    this.align,
    this.maxLines,
  }) : super(key: key);

  //   命名构造函数
  const StText.big(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.big,
          maxLines: maxLines,
          align: align,
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: defaultStyle,
      child: Text(
        text ?? '',
        maxLines: maxLines ?? 20,
        textAlign: align,
        textScaleFactor: TextScaleFactorListener.sizeScale.value / 10,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}

// 假设存在的标准文本样式类
class StandardTextStyle {
  static const TextStyle big = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

// 假设存在的文本缩放监听器类
class TextScaleFactorListener {
  static ValueNotifier<double> sizeScale = ValueNotifier(1.0);
}
