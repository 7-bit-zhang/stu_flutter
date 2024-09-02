import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:study_demo/main.dart';
import 'package:study_demo/pages/Hero/List_page.dart';
import 'package:study_demo/pages/QQ/qq_frame.dart';
import 'package:study_demo/pages/demo/AnimatedContainer_page.dart';
import 'package:study_demo/pages/demo/AnimationBuilder_page.dart';
import 'package:study_demo/pages/demo/AnimationController_page.dart';
import 'package:study_demo/pages/demo/AnimationController_page1.dart';
import 'package:study_demo/pages/demo/Autocomplete_page.dart';
import 'package:study_demo/pages/demo/BindingObserver_page.dart';
import 'package:study_demo/pages/demo/Curves_page.dart';
import 'package:study_demo/pages/demo/DargTarget_page.dart';
import 'package:study_demo/pages/demo/Dismissible_page.dart';
import 'package:study_demo/pages/demo/FutureBuilder_page.dart';
import 'package:study_demo/pages/demo/ListView_page.dart';
import 'package:study_demo/pages/demo/ListWheelScrollView_page.dart';
import 'package:study_demo/pages/demo/Magnifier_page.dart';
import 'package:study_demo/pages/demo/RangeSlider_page.dart';
import 'package:study_demo/pages/demo/ReorderableListView_page.dart';
import 'package:study_demo/pages/demo/Scrollable_Refresh_page.dart';
import 'package:study_demo/pages/demo/Shirne_page.dart';
import 'package:study_demo/pages/demo/SliverAppBar_page.dart';
import 'package:study_demo/pages/demo/TweenAnimationBuidlder_page.dart';
import 'package:study_demo/pages/demo/TweenAnimationBuidlder_page1.dart';
import 'package:study_demo/pages/demo/a.dart';
import 'package:study_demo/pages/demo/b.dart';
import 'package:study_demo/pages/demo/button_page.dart';
import 'package:study_demo/pages/demo/changeNotifier_page.dart';
import 'package:study_demo/pages/demo/code_qr.dart';
import 'package:study_demo/pages/demo/drag_page.dart';
import 'package:study_demo/pages/demo/draggableScrollableSheet_page.dart';
import 'package:study_demo/pages/demo/dropdownMenu_page.dart';
import 'package:study_demo/pages/demo/group_qr.dart';
import 'package:study_demo/pages/demo/rect_my.dart';
import 'package:study_demo/pages/demo/sliverMainAxisGroup_sliverPersistenHeader.dart';
import 'package:study_demo/pages/demo/sliver_top_keep.dart';
import 'package:study_demo/pages/demo/text_filed_type.dart';
import 'package:study_demo/pages/demo/transform_page.dart';
import 'package:study_demo/pages/demo/waterWaveProgressBar.dart';
import 'package:study_demo/pages/demo/watermark_page.dart';
import 'package:study_demo/pages/demoNew/start_page.dart';
import 'package:study_demo/pages/folding_cell-master/folding_cell_list_page.dart';
import 'package:study_demo/pages/graphview.dart';
import 'package:study_demo/pages/kirsch/kirsch.dart';
import 'package:study_demo/pages/sliver/page.dart';
import 'package:study_demo/pages/theme/themeDemo.dart';
import 'package:study_demo/pages/web.dart';
import 'package:study_demo/provide_page/provide_page.dart';
import 'package:study_demo/theme.dart';
import 'package:study_demo/web3demo/android_call.dart';
import 'package:study_demo/web3demo/web_page.dart';

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      // floatingActionButton: ChangeNotifierProvider<Test>(
      //   create: (_) => Test(),
      //   child: Consumer<Test>(
      //     builder: (BuildContext context, value, Widget? child) {
      //       return FloatingActionButton(onPressed: () {
      //         // print(Provider.of<Test>(context).counter);
      //       });
      //     },
      //   ),
      // ),
      body: PopScope(
        onPopInvokedWithResult: (b, d) async {
          await AndroidCall.backDesktop();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            TextField(
              onChanged: (v) {},
            ),
            const SizedBox(height: 10),
            const Text("DEMO",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            getItem("模仿QQ", const QQFrame()),
            const SizedBox(height: 20),
            getItem(
                "学习Demo",
                Scaffold(
                    appBar: AppBar(
                      title: const Text("Demo"),
                      backgroundColor: myColors.brandColor,
                    ),
                    body: qtItem())),
            const SizedBox(height: 20),
            getItem("Provide", const ProvidePage()),
            const SizedBox(height: 20),
            getItem("UI分享", const WebPage()),
            const SizedBox(height: 20),
            getItem("滚动视差效果", const Start()),
            const SizedBox(height: 20),
            getItem("1", const TreeViewPage()),
            const SizedBox(height: 20),
            getItem("WebViewPage", const WebViewPage()),
            const SizedBox(height: 20),
            getItem("HomePage11", const HomePage11()),
            const SizedBox(height: 20),
            getItem(
                "CustomSliverHeaderDemo",
                ScanPage(
                  phoneNumber: '',
                )),
            const SizedBox(height: 20),
            getItem("SliverPage", const SliverPage()),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "发现"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我的")
      ]),
    );
  }

  Widget qtItem() {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          getItem("TextFiledTypeExample", TextFiledTypeExample()),
          getItem(
              "sliverList分组 滚动吸顶单个",
              SliverMainAxisGroupPage(
                title: 'DATA',
                onScrollOffsetChanged: (double x, double y) {
                  print(x);
                  print(y);
                },
              )),
          const SizedBox(height: 20),
          getItem("父组件拦截子组件点击事件使用计算方式", RectParenPage()),
          const SizedBox(height: 20),
          getItem("水波球形进度条", const WaterWaveProgressPage()),
          const SizedBox(height: 20),
          getItem("自动吸顶sliver", MySliverApp()),
          const SizedBox(height: 20),
          getItem("切换主题 使用bloc 管理主题", const ThemeSwitch()),
          const SizedBox(height: 20),
          getItem(
              "类似于地图Map  上拉菜单  可拖动折叠", const DraggableScrollableSheetPage()),
          const SizedBox(height: 20),
          getItem("SliverAppbar 仿", const SelfHomePage()),
          const SizedBox(height: 20),
          getItem("输入框-自动提示", const AutoCompletePage()),
          const SizedBox(height: 20),
          getItem("放大镜", const MagnifierPage()),
          const SizedBox(height: 20),
          getItem("APP挂起后台模糊(安卓无效)", const BindingObserverPage()),
          const SizedBox(height: 20),
          getItem(
              "AnimatedContainer-简单动画效果(隐式)", const AnimatedContainerPage()),
          const SizedBox(height: 20),
          getItem("Curves-线性动画", const CurvesPage()),
          const SizedBox(height: 20),
          getItem("拖动条-透明度", const RangeSliderPage()),
          const SizedBox(height: 20),
          getItem("TweenAnimationBuidlder-补间动画",
              const TweenAnimationBuidlderPage()),
          const SizedBox(height: 20),
          getItem("TweenAnimationBuidlder-计数器",
              const TweenAnimationBuidlderPage1()),
          const SizedBox(height: 20),
          getItem("AnimationController-动画控制器", const AnimationControllerPage()),
          const SizedBox(height: 20),
          getItem("AnimationBuilder-自定义动画", const AnimationBuilderPage()),
          const SizedBox(height: 20),
          getItem("AnimatedContainer-多个动画控制器", const AnimatedContainerPage1()),
          const SizedBox(height: 20),
          getItem("Hero-动画效果", const ListHeroPage()),
          const SizedBox(height: 20),
          getItem("ReorderableListView-拖拽", const ReorderableListViewPage()),
          const SizedBox(height: 20),
          getItem("ListView-跳转动画", const ListViewPage()),
          const SizedBox(height: 20),
          getItem("Refresh-下拉刷新&上拉加载", const ScrollableRefreshPage()),
          const SizedBox(height: 20),
          getItem("Dismissible-左右滑动删除", const DismissiblePage()),
          const SizedBox(height: 20),
          getItem("ListWheelScrollView-3D列表", const ListWheelScrollViewPage()),
          const SizedBox(height: 20),
          getItem("FutureBuilder-异步构建", const FutureBuilderPage()),
          const SizedBox(height: 20),
          getItem("SliverAppBar", const SliverAppBarPage()),
          const SizedBox(height: 20),
          getItem("ButtonPage-DIY各种按钮", const ButtonPage()),
          const SizedBox(height: 20),
          getItem("Watermark-水印", const WatermarkPage()),
          const SizedBox(height: 20),
          getItem("拖拽放大自定义组件", const Shirne()),
          const SizedBox(height: 20),
          getItem("组件截图", GroupQr()),
          const SizedBox(height: 20),
          getItem("ChangeNotifier-自定义控制器", const ChangeNotifierPage()),
          const SizedBox(height: 20),
          getItem("Transform实现3D效果", const TransformPage()),
          const SizedBox(height: 20),
          getItem("折叠卡片", const FoldingCellListPage()),
          const SizedBox(height: 20),
          getItem("左右拖拽大小", const DragPage()),
          const SizedBox(height: 20),
          getItem("转换图片颜色值生成新图片", const Kirsch()),
          const SizedBox(height: 20),
          getItem("DargTarget-调色", const DargTargetPage()),
          const SizedBox(height: 20),
          getItem("DropdownMenuPage", const DropdownMenuPage()),
        ],
      ),
    );
  }
}

Widget getItem(String text, Widget goto) {
  Color color = const Color.fromARGB(255, 246, 247, 251);
  return GestureDetector(
    onTap: () {
      Get.to(goto);
    },
    child: Container(
      alignment: Alignment.center,
      height: 100,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}
