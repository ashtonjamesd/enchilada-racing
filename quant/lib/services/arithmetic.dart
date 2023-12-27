import 'dart:math';

import 'package:quant/models/question.dart';

class ArithmeticService
{

  ArithmeticQuestion generateQuestion() {

    Random random = Random();

    int firstNumber = random.nextInt(20);
    int secondNumber = random.nextInt(20);

    int questionAnswer = firstNumber;
    String questionString = "Find  𝑥  such that  𝑥 + $secondNumber = ${firstNumber + secondNumber}";

    return ArithmeticQuestion(question: questionString, type: "math", answer: questionAnswer);
  }
}