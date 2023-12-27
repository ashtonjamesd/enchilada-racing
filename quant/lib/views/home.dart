import 'package:flutter/material.dart';
import 'package:quant/widgets/logout_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quant"),
        leading: LogoutButton(),
      ),
      body: Container(),
    );
  }
}