import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:study_demo/frame.dart';
import 'package:study_demo/pages/theme/theme_style.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Number of method calls to be displayed
    errorMethodCount: 8, // Number of method calls if stacktrace is provided
    lineLength: 120, // Width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
);
void demo() {
  logger.d('Log message with 2 methods');

  logger.i({'key': 5, 'value': 'something'});

  logger.w('Just a warning!');

  logger.e('Error! Something bad happened', error: 'Test Error');

  logger.t({'key': 5, 'value': 'something'});

  Logger(printer: SimplePrinter(colors: true)).t('boom');
}

void main() {
  TextInputBinding();
  //Provider.debugCheckInvalidValueType = null;
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
  //     overlays: []);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, // 设置状态栏为透明
  // ));
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
  demo();
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
          // navigatorObservers: [FlutterSmartDialog.observer],
          // builder: FlutterSmartDialog.init(),
        );
      },
    );
  }
}
