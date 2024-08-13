import 'package:flutter/material.dart';
import 'package:study_demo/pages/demo/customSliverHeaderDemo.dart';

// ignore: must_be_immutable
class MySliverApp extends StatelessWidget {
  ScrollController controller = ScrollController();

  MySliverApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: controller,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverCustomHeaderDelegate(
            controller: controller,
            collapsedHeight: 60,
            expandedHeight: 500,
            paddingTop: MediaQuery.of(context).padding.top,
            defaultCollapsedColor: Colors.black,
            expandedWidget:
                const Center(child: SizedBox(child: Text("123123123"))),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              height: 100,
              color: Colors.red,
            );
          },
          itemCount: 20,
        )
      ],
    )
        // CustomScrollView(
        //   slivers: <Widget>[
        //     // SliverAppBar 实现动态切换 flexibleSpace
        //     SliverAppBar(
        //       pinned: true,
        //       expandedHeight: 500.0,
        //       flexibleSpace: LayoutBuilder(
        //         builder: (BuildContext context, BoxConstraints constraints) {
        //           // 计算 SliverAppBar 的滚动距离
        //           double shrinkOffset = constraints.maxHeight - kToolbarHeight;
        //           bool isCollapsed = shrinkOffset < 120; // 判断是否接近最小化
        //           print(isCollapsed);
        //           return FlexibleSpaceBar(
        //             background: isCollapsed
        //                 ? Container(
        //                     color: Colors.blueAccent,
        //                     child: Center(child: Text('Collapsed View')),
        //                   )
        //                 : Container(
        //                     decoration: BoxDecoration(
        //                       gradient: LinearGradient(
        //                         colors: [Colors.orange, Colors.pink],
        //                         begin: Alignment.topCenter,
        //                         end: Alignment.bottomCenter,
        //                       ),
        //                     ),
        //                     child: Center(child: Text('Expanded View')),
        //                   ),
        //           );
        //         },
        //       ),
        //     ),
        //     // 其他内容
        //     SliverToBoxAdapter(
        //       child: Container(
        //         height: 1000,
        //         color: Colors.grey[200],
        //         child: Center(child: Text('内容区')),
        //       ),
        //     ),
        //   ],
        // ),

        );
  }
}
