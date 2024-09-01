// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class TextFiledTypeExample extends StatefulWidget {
  TextFiledTypeExample({super.key});
  final TextFiledTypeController controller = TextFiledTypeController();
  @override
  State<TextFiledTypeExample> createState() => _TextFiledTypeExampleState();
}

class _TextFiledTypeExampleState extends State<TextFiledTypeExample> {
  ///测试
  onTest() {
    var controller = TextEditingController();
    var data1 = TextFiledTypeControllerTypedef(
        controller: controller,
        textFiledType: TextFiledTypeWidget(
            controller: controller,
            label: const Text(
              "项目名称",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            hintText: "hintText"));
    var data2 = TextFiledTypeControllerTypedef(
        controller: controller,
        textFiledType: TextFiledTypeWidget(
          controller: controller,
          label: const Text("项目价格",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          endWidget: const Text("元",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
        ));

    if (widget.controller.textFiledTypeTypedefs.length % 2 == 0) {
      widget.controller.add(
          key: widget.controller.textFiledTypeTypedefs.length.toString(),
          value: data1);
    } else {
      widget.controller.add(
          key: widget.controller.textFiledTypeTypedefs.length.toString(),
          value: data2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 222, 247),
      appBar: AppBar(
        title: const Text("TextFiledTypeExample"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(widget.controller.textFiledTypeTypedefs.entries.map(
            (d) => print("key: ${d.key},value: ${d.value.controller.text}")));
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
                    children: widget.controller.textFiledTypeTypedefs.entries
                        .map((data) => Builder(builder: (context) {
                              return Column(
                                children: [
                                  data.value.textFiledType,
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
            onTap: onTest,
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
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              widget.controller.remove("1");
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
                      "删除key1",
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
  final Map<String, TextFiledTypeTypedef> _textFiledTypeTypedefs = {};

  Map<String, TextFiledTypeTypedef> get textFiledTypeTypedefs =>
      _textFiledTypeTypedefs;

  //set
  void add({required String key, required TextFiledTypeTypedef value}) {
    _textFiledTypeTypedefs[key] = value;
    //呼叫所有监听的人进行重新绘制
    notifyListeners();
  }

  void remove(String key) {
    _textFiledTypeTypedefs.remove(key);
    //呼叫所有监听的人进行重新绘制
    notifyListeners();
  }
}

class TextFiledTypeControllerTypedef {
  /// textFiledType
  late TextFiledTypeWidget textFiledType;

  /// controller
  late TextEditingController controller;

  /// 构造方法
  TextFiledTypeControllerTypedef(
      {required this.controller, required this.textFiledType});
}

class TextFiledTypeWidget extends StatefulWidget {
  const TextFiledTypeWidget(
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
  State<TextFiledTypeWidget> createState() => _TextFiledTypeWidgetState();
}

class _TextFiledTypeWidgetState extends State<TextFiledTypeWidget> {
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

class FrogColor extends InheritedWidget {
  const FrogColor({
    super.key,
    required this.color,
    required super.child,
  });

  final Color color;

  static FrogColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  static FrogColor of(BuildContext context) {
    final FrogColor? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}

class CounterProvider extends InheritedNotifier<ValueNotifier<int>> {
  const CounterProvider(
      {Key? key, required Widget child, required this.counter})
      : super(key: key, child: child);

  final ValueNotifier<int> counter;

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }
}

class CounterController with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ValueNotifier & InheritedNotifier Example'),
        ),
        body: const CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: ValueNotifier<int>(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          ValueListenableBuilder(
            valueListenable: CounterProvider.of(context).counter,
            builder: (context, int value, child) {
              return Text(
                value.toString(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              CounterProvider.of(context).counter.value++;
            },
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
