import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_demo/theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static ThemeData data = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.transparent))),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 80,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: Color(0xFF212529)),
    ),
  );

  static final _lightTheme = data.copyWith(
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      const MyColors(
        brandColor: Color(0xFF1E88E5),
        danger: Color(0xFFE53935),
      ),
    ],
  );

  static final _darkTheme = data.copyWith(
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      const MyColors(
        brandColor: Color(0xFF90CAF9),
        danger: Color(0xFFEF9A9A),
      ),
    ],
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _darkTheme : _lightTheme);
    print(state.brightness);
  }
}
