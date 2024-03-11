import 'package:flutter/material.dart';

import 'home/home.dart';

Future main() async => runApp(const SylvanianApp());

class SylvanianApp extends StatelessWidget {
  const SylvanianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}