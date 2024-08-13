// ignore_for_file: file_names, library_private_types_in_public_api, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';

class DarkSample extends StatefulWidget {
  const DarkSample({super.key});

  @override
  _DarkSampleState createState() => _DarkSampleState();
}

class _DarkSampleState extends State<DarkSample> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late Offset circleOffset = Offset(size.width, size.height);
    return GestureDetector(
      onTapDown: (e) {
        circleOffset = e.localPosition;
      },
      child: DarkTransition(
        childBuilder: (context, x) => MyHomePage(
          title: 'Flutter Demo Home Page',
          onIncrement: () {
            setState(() {
              isDark = !isDark;
            });
          },
        ),
        offset: circleOffset,
        isDark: isDark,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Function()? onIncrement;

  const MyHomePage({
    Key? key,
    this.onIncrement,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() {
    widget.onIncrement!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text('$_counter'),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class DarkTransition extends StatefulWidget {
  const DarkTransition(
      {required this.childBuilder,
      Key? key,
      this.offset = Offset.zero,
      this.themeController,
      this.radius,
      this.duration = const Duration(milliseconds: 400),
      this.isDark = false})
      : super(key: key);

  /// Deinfe the widget that will be transitioned
  /// int index is either 1 or 2 to identify widgets, 2 is the top widget
  final Widget Function(BuildContext, int) childBuilder;

  /// the current state of the theme
  final bool isDark;

  /// optional animation controller to controll the animation
  final AnimationController? themeController;

  /// centeral point of the circular transition
  final Offset offset;

  /// optional radius of the circle defaults to [max(height,width)*1.5])
  final double? radius;

  /// duration of animation defaults to 400ms
  final Duration? duration;

  @override
  _DarkTransitionState createState() => _DarkTransitionState();
}

class _DarkTransitionState extends State<DarkTransition>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _darkNotifier.dispose();
    super.dispose();
  }

  final _darkNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    if (widget.themeController == null) {
      _animationController =
          AnimationController(vsync: this, duration: widget.duration);
    } else {
      _animationController = widget.themeController!;
    }
  }

  double _radius(Size size) {
    final maxVal = max(size.width, size.height);
    return maxVal * 1.5;
  }

  late AnimationController _animationController;
  double x = 0;
  double y = 0;
  bool isDark = false;
  // bool isBottomThemeDark = true;
  bool isDarkVisible = false;
  late double radius;
  Offset position = Offset.zero;

  ThemeData getTheme(bool dark) {
    if (dark)
      return ThemeData.dark();
    else
      return ThemeData.light();
  }

  @override
  void didUpdateWidget(DarkTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _darkNotifier.value = widget.isDark;
    if (widget.isDark != oldWidget.isDark) {
      if (isDark) {
        _animationController.reverse();
        _darkNotifier.value = false;
      } else {
        _animationController.reset();
        _animationController.forward();
        _darkNotifier.value = true;
      }
      position = widget.offset;
    }
    if (widget.radius != oldWidget.radius) {
      _updateRadius();
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRadius();
  }

  void _updateRadius() {
    final size = MediaQuery.of(context).size;
    if (widget.radius == null)
      radius = _radius(size);
    else
      radius = widget.radius!;
  }

  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    Widget _body(int index) {
      return ValueListenableBuilder<bool>(
          valueListenable: _darkNotifier,
          builder: (BuildContext context, bool isDark, Widget? child) {
            return Theme(
                data: index == 2
                    ? getTheme(!isDarkVisible)
                    : getTheme(isDarkVisible),
                child: widget.childBuilder(context, index));
          });
    }

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              _body(1),
              ClipPath(
                  clipper: CircularClipper(
                      _animationController.value * radius, position),
                  child: _body(2)),
            ],
          );
        });
  }
}

class CircularClipper extends CustomClipper<Path> {
  const CircularClipper(this.radius, this.center);
  final double radius;
  final Offset center;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addOval(Rect.fromCircle(radius: radius, center: center));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
