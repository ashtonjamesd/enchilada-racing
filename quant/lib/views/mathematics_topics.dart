import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/views/mathematics.dart';
import 'package:quant/widgets/arithmetic/topic.dart';

class MathematicsTopics extends StatelessWidget {
  MathematicsTopics({super.key});

  final List<Topic> topics = [
    Topic(title: "Simple Arithmetic"),
    Topic(title: "Algebraic Equations")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColour,
      appBar: AppBar(
        backgroundColor: appBarColour,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                Topic topic = topics[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Mathematics(topic: topic,)));
                    playTimer.start();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: primarydarkBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
