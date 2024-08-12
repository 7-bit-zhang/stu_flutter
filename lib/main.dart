import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:study_demo/frame.dart';
import 'package:study_demo/pages/theme/theme_style.dart';

void main() {
  TextInputBinding();
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
  //     overlays: []);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, // 设置状态栏为透明
  // ));
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (BuildContext context, state) {
        debugPrint(state.extensions.toString());
        return GetMaterialApp(
          title: '7bit - Demo',
          debugShowCheckedModeBanner: false,
          theme: state,
          home: const FramePage(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
