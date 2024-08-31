// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class TextFiledTypeExample extends StatefulWidget {
  const TextFiledTypeExample({super.key});

  @override
  State<TextFiledTypeExample> createState() => _TextFiledTypeExampleState();
}

class _TextFiledTypeExampleState extends State<TextFiledTypeExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 213, 253),
      appBar: AppBar(
        title: const Text("TextFiledTypeExample"),
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffdfebff),
            borderRadius: BorderRadius.circular(10)),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFiledTypeTypedef(
              label: Text("项目名称", style: TextStyle(fontSize: 16)),
              hintText: "请输入用户名",
              endWidget: Text("元"),
            ),
            TextFiledTypeTypedef(
              label: Text("项目名称", style: TextStyle(fontSize: 16)),
              hintText: "请输入用户名",
              endWidget: Text("元"),
            ),
          ],
        ),
      )),
    );
  }
}

typedef TextFiledTypeTypedef = _TextFiledType;

class _TextFiledType extends StatefulWidget {
  const _TextFiledType(
      {super.key,
      this.label,
      this.hintText,
      this.endWidget,
      this.keyboardType,
      this.padding = const EdgeInsets.symmetric(horizontal: 15),
      this.hintStyle = const TextStyle(color: Colors.grey)});

  /// label
  final Widget? label;

  /// hintText
  final String? hintText;

  /// hintStyle
  final TextStyle hintStyle;

  /// endWidget
  final Widget? endWidget;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// padding
  final EdgeInsetsGeometry padding;
  @override
  State<_TextFiledType> createState() => _TextFiledTypeState();
}

class _TextFiledTypeState extends State<_TextFiledType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: widget.keyboardType,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: widget.label,
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle),
            ),
          ),
          const SizedBox(width: 5),
          widget.endWidget ?? const SizedBox()
        ],
      ),
    );
  }
}
