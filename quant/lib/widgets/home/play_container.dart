import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/views/arithmetic.dart';

class PlayContainer extends StatefulWidget {
  const PlayContainer({super.key});

  @override
  State<PlayContainer> createState() => _PlayContainerState();
}

class _PlayContainerState extends State<PlayContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Arithmetic()));
          },
          child: Container(
            width: 360,
            height: 160,
            decoration: BoxDecoration(
              color: containerColour,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                "Arithmetic",
                style: primaryFont(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}