import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/widgets/home/play_container.dart';
import 'package:quant/widgets/home/profile_button.dart';
import 'package:quant/widgets/home/logout_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColour,
      appBar: AppBar(
        backgroundColor: appBarColour,
        leading: LogoutButton(),
        actions: const [
          ProfileButton()
        ],
      ),
      body: const Column(
        children: [
          PlayContainer(),
        ],
      ),
    );
  }
}