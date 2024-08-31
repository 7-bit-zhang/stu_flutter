import 'package:flutter/material.dart';

class TextFiledTypeExample extends StatefulWidget {
  const TextFiledTypeExample({super.key});

  @override
  State<TextFiledTypeExample> createState() => _TextFiledTypeExampleState();
}

class _TextFiledTypeExampleState extends State<TextFiledTypeExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextFiledTypeExample"),
      ),
    );
  }
}
