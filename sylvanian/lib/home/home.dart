import 'package:flutter/material.dart';

import '../globals.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/sylvanianlogo.jpg",
              width: 300,
            ),
            Text(
              "sylvania",
              style: fontStyle.copyWith(
                fontSize: 70,
                color: Colors.grey,
              ),
            ),
            Text(
              "for maisie",
              style: fontStyle.copyWith(
                fontSize: 32,
                color: Colors.grey,
              ),          
            ),
          ],
        ),
      ),
    );
  }
}
