import 'package:flutter/material.dart';

class ProvidePage extends StatefulWidget {
  const ProvidePage({super.key});

  @override
  State<ProvidePage> createState() => _ProvidePageState();
}

class _ProvidePageState extends State<ProvidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provide")),
    );
  }
}
