// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DebouncedSearch {
  late Duration duration;
  Timer? _timer;

  DebouncedSearch({required this.duration});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}

/// 自定义顶部滑动
class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// 折叠高度
  final double collapsedHeight;

  /// 展开高度
  final double expandedHeight;

  /// 顶部距离
  final double paddingTop;

  /// 滚动控制器
  ScrollController? controller;

  /// 折叠后显示组件
  final Widget? collapsedWidget;

  /// 展开后显示组件
  final Widget expandedWidget;

  /// 展开时的背景颜色
  final Color? expandedColors;

  /// 折叠时的背景颜色
  final Color? collapsedColors;

  /// 默认的折叠组件Title
  final String? defaultCollapsedTitle;

  /// 默认的折叠组件Title
  final Color? defaultCollapsedColor;

  /// 动画执行时间
  /// 默认 300ms
  late Duration durationAnimation;
  SliverCustomHeaderDelegate(
      {this.controller,
      this.collapsedWidget,
      this.collapsedColors,
      this.expandedColors,
      this.defaultCollapsedTitle,
      this.defaultCollapsedColor,
      this.durationAnimation = const Duration(milliseconds: 300),
      required this.collapsedHeight,
      required this.expandedHeight,
      required this.paddingTop,
      required this.expandedWidget});

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  ///防抖
  /// 防抖动，防止多次触发
  /// 100ms内只触发一次
  final debouncer =
      DebouncedSearch(duration: const Duration(milliseconds: 100));

  ///默认折叠组件
  Widget _defaultCollapsedWidget(dynamic shrinkOffset) {
    return Center(
      child: Text(
        defaultCollapsedTitle ?? "Appbar",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: _makeStickyHeaderTextColor(shrinkOffset, true),
        ),
      ),
    );
  }

  /// 更新状态栏
  void _updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset <= maxExtent / 2) {
      debouncer.run(() {
        controller?.animateTo(0,
            duration: durationAnimation, curve: Curves.ease);
      });
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else if (shrinkOffset > maxExtent / 2 &&
        shrinkOffset <= maxExtent - (paddingTop * 2.5)) {
      debouncer.run(() {
        controller?.animateTo(maxExtent - (paddingTop * 2.5),
            duration: durationAnimation, curve: Curves.ease);
      });
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }

  /// 计算透明度
  double _makeStickyHeaderTitleAlpha(shrinkOffset) {
    final double alpha =
        (shrinkOffset / (maxExtent - minExtent) * 1).clamp(0, 1).toDouble();
    return alpha;
  }

  /// 背景颜色
  Color _makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();

    /// 使用传递的RGB
    if (collapsedColors case Color color?) {
      return Color.fromARGB(alpha, color.red, color.green, color.blue);
    }

    /// 默认RGB 绿色
    return Color.fromARGB(alpha, 177, 216, 92);
  }

  /// 文字颜色
  Color _makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();

    /// 使用传递的RGB
    if (defaultCollapsedColor case Color color?) {
      return Color.fromARGB(alpha, color.red, color.green, color.blue);
    }
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    _updateStatusBarBrightness(shrinkOffset);
    return Container(
      color: _makeStickyHeaderBgColor(shrinkOffset),
      height: maxExtent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
            height: collapsedHeight,
            child: Stack(children: [
              Opacity(
                  opacity: 1 - _makeStickyHeaderTitleAlpha(shrinkOffset),
                  child: expandedWidget),
              Opacity(
                  opacity: _makeStickyHeaderTitleAlpha(shrinkOffset),
                  child:
                      collapsedWidget ?? _defaultCollapsedWidget(shrinkOffset)),
            ])),
      ),
    );
  }
}

class FilmContent extends StatelessWidget {
  const FilmContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  'https://img1.gamersky.com/image2019/07/20190725_ll_red_136_2/gamersky_07small_14_201972510258D0.jpg',
                  width: 130,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 16)),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '哪吒之魔童降世',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    '动画/中国大陆/110分钟',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    '2019-07-26 08:00 中国大陆上映',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    '32.1万人想看/大V推荐度95%',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 32),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '剧情简介',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                '天地灵气孕育出一颗能量巨大的混元珠，元始天尊将混元珠提炼成灵珠和魔丸，灵珠投胎为人，助周伐纣时可堪大用；而魔丸则会诞出魔王，为祸人间。元始天尊启动了天劫咒语，3年后天雷将会降临，摧毁魔丸。太乙受命将灵珠托生于陈塘关李靖家的儿子哪吒身上。然而阴差阳错，灵珠和魔丸竟然被掉包。本应是灵珠英雄的哪吒却成了混世大魔王。调皮捣蛋顽劣不堪的哪吒却徒有一颗做英雄的心。然而面对众人对魔丸的误解和即将来临的天雷的降临，哪吒是否命中注定会立地成魔？他将何去何从？',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
