import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/question.dart';
import 'package:quant/services/arithmetic.dart';

class Arithmetic extends StatefulWidget {
  Arithmetic({super.key});

  @override
  State<Arithmetic> createState() => _ArithmeticState();
}

class _ArithmeticState extends State<Arithmetic> {
  ArithmeticService arithmetic = ArithmeticService();

  @override
  Widget build(BuildContext context) {
    
    ArithmeticQuestion arithmeticQuestion = arithmetic.generateQuestion();
    TextEditingController answerController = TextEditingController();

    int correctAnswers = 0;
    int questionsAnswered = 0;

    return Scaffold(
    backgroundColor: primaryBackgroundColour,
      appBar: AppBar(
        title: const Text(
          "Solving Algebraic Equations",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: containerColour,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 320,
              height: 400,
              decoration: BoxDecoration(
                color: containerColour,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      arithmeticQuestion.question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 180,
                            child: TextField(
                              controller: answerController,
                              style: const TextStyle(
                                fontSize: 14
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Answer...',
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: IconButton(
                            onPressed: () {
                              questionsAnswered = questionsAnswered + 1;
          
                              if (answerController.text == arithmeticQuestion.answer.toString()){
                                correctAnswers = correctAnswers + 1;
                              }
          
                              setState(() {
                                arithmeticQuestion = arithmetic.generateQuestion();
                              });
                            }, 
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 143, 143, 143),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8),
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}