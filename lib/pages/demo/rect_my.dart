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
      body: MyHomePage(
        title: '',
      ),
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

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverMainAxisGroup(slivers: [
            const SliverPersistentHeader(
              pinned: true,
              delegate: HeaderDelegate('Section 1'),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: _getDecoratedSliverList(10),
            ),
          ]),
          SliverMainAxisGroup(slivers: [
            const SliverPersistentHeader(
              pinned: true,
              delegate: HeaderDelegate('Section 2'),
            ),
            SliverCrossAxisGroup(
              slivers: [
                SliverConstrainedCrossAxis(
                  maxExtent: 100,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: _getDecoratedSliverList(10),
                  ),
                ),
                SliverCrossAxisExpanded(
                  flex: 2,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: _getDecoratedSliverList(20),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: _getDecoratedSliverList(10),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _getDecoratedSliverList(int itemCount) {
    return DecoratedSliver(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      sliver: SliverList.separated(
        itemBuilder: (_, int index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Item $index'),
        ),
        separatorBuilder: (_, __) => const Divider(indent: 8, endIndent: 8),
        itemCount: itemCount,
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  const HeaderDelegate(this.title);
  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: 30,
        color: Colors.purple[100],
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(title),
        ));
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
