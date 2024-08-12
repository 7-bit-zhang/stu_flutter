// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

//name：zhangyu
//date：2023-7-21
//introduce：放大镜
class MagnifierPage extends StatefulWidget {
  const MagnifierPage({super.key});

  @override
  State<MagnifierPage> createState() => _MagnifierPageState();
}

class _MagnifierPageState extends State<MagnifierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("DIY组件放大镜-Demo", context),
      body: Magnifier(child: Image.asset("assets/images/girl.jpg")),
    );
  }
}

class Magnifier extends StatefulWidget {
  final Widget child;
  final double magnification;

  const Magnifier({
    Key? key,
    required this.child,
    this.magnification = 2.0,
  }) : super(key: key);

  @override
  _MagnifierState createState() => _MagnifierState();
}

class _MagnifierState extends State<Magnifier> {
  Offset? _offset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        Positioned.fill(
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              final childSize = constraints.biggest;
              return Listener(
                onPointerMove: (event) {
                  setState(() {
                    _offset = event.localPosition;
                  });
                },
                child: MouseRegion(
                  onHover: (event) {
                    setState(() => _offset = event.localPosition);
                  },
                  onExit: (_) => setState(() => _offset = null),
                  child: _offset != null
                      ? _buildBox(_offset!.dx, _offset!.dy, childSize)
                      : null,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildBox(double dx, double dy, Size childSize) {
    final magnifierSize = childSize.shortestSide / 2;
    return Transform.translate(
      offset: Offset(dx - magnifierSize / 2, dy - magnifierSize / 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: Stack(
          children: [
            SizedBox(
              width: magnifierSize,
              height: magnifierSize,
              child: ClipRect(
                child: Transform.scale(
                  scale: widget.magnification,
                  child: Transform.translate(
                    offset: Offset(
                      childSize.width / 2 - dx,
                      childSize.height / 2 - dy,
                    ),
                    child: OverflowBox(
                      minWidth: childSize.width,
                      maxWidth: childSize.width,
                      minHeight: childSize.height,
                      maxHeight: childSize.height,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.green.withOpacity(0.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
