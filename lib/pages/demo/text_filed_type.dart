// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class TextFiledTypeExample extends StatefulWidget {
  TextFiledTypeExample({super.key});
  final TextFiledTypeController controller = TextFiledTypeController();
  @override
  State<TextFiledTypeExample> createState() => _TextFiledTypeExampleState();
}

class _TextFiledTypeExampleState extends State<TextFiledTypeExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 222, 247),
      appBar: AppBar(
        title: const Text("TextFiledTypeExample"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(widget.controller.textFiledTypeTypedefs
            .map((d) => print(d.controller.text)));
      }),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xffdfebff),
                borderRadius: BorderRadius.circular(12)),
            child: ListenableBuilder(
              listenable: widget.controller,
              builder: (context, Widget? child) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.controller.textFiledTypeTypedefs
                        .map((data) => Builder(builder: (context) {
                              return Column(
                                children: [
                                  data.textFiledType,
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Divider(
                                      height: .5,
                                      thickness: .5,
                                      color: Colors.black12,
                                    ),
                                  )
                                ],
                              );
                            }))
                        .toList());
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              var controller = TextEditingController();
              if (widget.controller.textFiledTypeTypedefs.length % 2 == 0) {
                widget.controller.add(TextFiledTypeControllerTypedef(
                    controller: controller,
                    textFiledType: TextFiledType(
                        controller: controller,
                        label: const Text("项目价格",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                        endWidget: const Text("元",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                        hintText: "")));
              } else {
                widget.controller.add(TextFiledTypeControllerTypedef(
                    controller: controller,
                    textFiledType: TextFiledType(
                        controller: controller,
                        label: const Text(
                          "项目名称",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        hintText: "hintText")));
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffdfebff),
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Color(0xff5091fd)),
                    Text(
                      "新增项目",
                      style: TextStyle(color: Color(0xff5091fd)),
                    )
                  ],
                )),
          ),
        ],
      )),
    );
  }
}

/// 测试写法
typedef TextFiledTypeTypedef = TextFiledTypeControllerTypedef;

/// textFiledTypeTypedef  ChangeNotifier
class TextFiledTypeController extends ChangeNotifier {
  // textFiledTypeTypedefs
  final List<TextFiledTypeTypedef> _textFiledTypeTypedefs = [];

  List<TextFiledTypeTypedef> get textFiledTypeTypedefs =>
      _textFiledTypeTypedefs;

  //set
  void add(TextFiledTypeTypedef value) {
    _textFiledTypeTypedefs.add(value);
    //呼叫所有监听的人进行重新绘制
    notifyListeners();
  }

  void remove(TextFiledTypeTypedef value) {
    _textFiledTypeTypedefs.remove(value);
    //呼叫所有监听的人进行重新绘制
    notifyListeners();
  }
}

class TextFiledTypeControllerTypedef {
  /// textFiledType
  late TextFiledType textFiledType;

  /// controller
  late TextEditingController controller;

  /// 构造方法
  TextFiledTypeControllerTypedef(
      {required this.controller, required this.textFiledType});
}

class TextFiledType extends StatefulWidget {
  const TextFiledType(
      {super.key,
      this.label,
      this.hintText,
      this.endWidget,
      this.keyboardType,
      required this.controller,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      this.hintStyle = const TextStyle(
          color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300)});

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

  /// controller
  final TextEditingController controller;
  @override
  State<TextFiledType> createState() => _TextFiledTypeState();
}

class _TextFiledTypeState extends State<TextFiledType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
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
