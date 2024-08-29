import 'package:flutter/material.dart';

class RectParenPage extends StatefulWidget {
  const RectParenPage({super.key});

  @override
  State<RectParenPage> createState() => _RectParenPageState();
}

class _RectParenPageState extends State<RectParenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ParentWidget(),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  GlobalKey childKey = GlobalKey();

  void _onPointerDown(PointerDownEvent event) {
    // 获取子组件的位置和大小
    RenderBox renderBox =
        childKey.currentContext?.findRenderObject() as RenderBox;
    Offset childPosition = renderBox.localToGlobal(Offset.zero);
    Size childSize = renderBox.size;
    Rect childRect = childPosition & childSize;

    // 检查点击位置是否在子组件的Rect内
    if (childRect.contains(event.position)) {
      print("点击在子组件内，触发子组件点击事件");
      // 手动触发子组件的点击逻辑
      _triggerChildTap();
    } else {
      print("点击在子组件外，未触发子组件点击事件");
    }
  }

  void _triggerChildTap() {
    // 这里可以触发子组件的点击事件逻辑
    print("子组件点击事件被手动触发");
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown, // 捕获按下事件
      child: Stack(
        children: [
          // 父组件的其他内容
          Positioned(
            left: 50,
            top: 100,
            child: ChildWidget(key: childKey),
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("子组件被点击");
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: Center(child: Text("子组件")),
      ),
    );
  }
}
