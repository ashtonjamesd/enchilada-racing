import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/question.dart';
import 'package:quant/services/mathematics.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/services/database.dart';
import 'package:quant/widgets/arithmetic/game_summary.dart';
import 'package:quant/widgets/arithmetic/topic.dart';

class Mathematics extends StatefulWidget {
  const Mathematics({Key? key, required this.topic});

  final Topic topic;

  @override
  State<Mathematics> createState() => _MathematicsState();
}

class _MathematicsState extends State<Mathematics> {
  ArithmeticService arithmetic = ArithmeticService();

  IconData answerIcon = Icons.question_mark;
  Color answerIconColour = Colors.white;

  int correctAnswers = 0;
  int incorrectAnswers = 0;

  @override
  Widget build(BuildContext context) {
    
    MathQuestion mathQuestion = arithmetic.generateQuestion(widget.topic.title);

    DatabaseService database = DatabaseService();
    AuthService auth = AuthService();

    TextEditingController answerController = TextEditingController();

    return Scaffold(
      backgroundColor: primaryBackgroundColour,
      appBar: AppBar(
        title: Text(
          widget.topic.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: containerColour,
        leading: GameSummary(correctAnswers: correctAnswers, incorrectAnswers: incorrectAnswers),
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
                      mathQuestion.question,
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
                              if (answerController.text == mathQuestion.answer.toString())
                              {
                                database.incrementProblemsSolved(auth.returnCurrentUser()!.uid);
                                database.checkForAchievements(auth.returnCurrentUser()!.uid);

                                database.incrementExperiencePoints(auth.returnCurrentUser()!.uid, 1);
                                
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
                                mathQuestion = arithmetic.generateQuestion(widget.topic.title);
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
