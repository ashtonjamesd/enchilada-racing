import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/question.dart';
import 'package:quant/services/arithmetic.dart';
import 'package:quant/widgets/arithmetic/game_summary.dart';

class Arithmetic extends StatefulWidget {
  Arithmetic({super.key});

  @override
  State<Arithmetic> createState() => _ArithmeticState();
}

class _ArithmeticState extends State<Arithmetic> {
  ArithmeticService arithmetic = ArithmeticService();

  IconData answerIcon = Icons.question_mark;
  Color answerIconColour = Colors.white;

  int correctAnswers = 0;
  int questionsAnswered = 0;
  int incorrectAnswers = 0;

  @override
  Widget build(BuildContext context) {
    
    ArithmeticQuestion arithmeticQuestion = arithmetic.generateQuestion();
    TextEditingController answerController = TextEditingController();


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
        leading: GameSummary(correctAnswers: correctAnswers, incorrectAnswers: incorrectAnswers)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 320,
              height: 240,
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
                            height: 40,
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
                          height: 38,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              questionsAnswered = questionsAnswered + 1;
          
                              if (answerController.text == arithmeticQuestion.answer.toString())
                              {
                                
                                setState(() {
                                  correctAnswers = correctAnswers + 1;
                                  answerIcon = Icons.check;
                                  answerIconColour = Colors.green;
                                });
                              }
                              else
                              {
                                setState(() {
                                  incorrectAnswers = incorrectAnswers + 1;
                                  answerIconColour = Colors.red;
                                  answerIcon = Icons.close;
                                });
                              }
          
                              setState(() {
                                arithmeticQuestion = arithmetic.generateQuestion();
                              });
                            }, 
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 189, 189, 189),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Icon(
                          answerIcon,
                          color: answerIconColour,
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