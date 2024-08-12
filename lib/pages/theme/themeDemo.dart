import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_demo/pages/theme/theme_style.dart';
import 'package:study_demo/theme.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return BlocBuilder<ThemeCubit, ThemeData>(
        builder: (BuildContext context, ThemeData state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("主题切换"),
            backgroundColor: myColors.brandColor,
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(
                  state.brightness == Brightness.dark
                      ? Icons.nightlight
                      : Icons.wb_sunny,
                  color: myColors.danger),
              onPressed: () {
                //切换
                context.read<ThemeCubit>().toggleTheme();
              }));
    });
  }
}
