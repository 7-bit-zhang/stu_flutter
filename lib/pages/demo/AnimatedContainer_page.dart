// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

//name：zhangyu
//date：2023-7-21
//introduce：AnimatedContainer-简单动画效果(隐式)
class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  var radius = 0.0;
  var width = 300.0;
  var height = 300.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("AnimatedContainer简单动画-Demo", context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(radius)),
            ),
          ),
          TextButton(
              onPressed: () {
                if (radius == 0) {
                  radius = 300;
                  height = 10;
                  width = 10;
                } else {
                  radius = 0;
                  height = 300;
                  width = 300;
                }
                setState(() {});
              },
              child: const Text("点击执行动画"))
        ],
      ),
    );
  }
}
