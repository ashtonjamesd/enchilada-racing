import 'dart:math';

import 'package:quant/models/question.dart';

class ArithmeticService
{
  Random random = Random();

  MathQuestion generateQuestion(String topicTitle){

    if (topicTitle == "Simple Arithmetic"){
      return generateSimpleArithmeticQuestion();
    }
    else if (topicTitle == "Algebraic Equations"){
      return generateAlgebraicEquationQuestion();
    }
    return generateSimpleArithmeticQuestion(); // default
  }

  MathQuestion generateAlgebraicEquationQuestion() {

    int firstNumber = random.nextInt(20);
    int secondNumber = random.nextInt(20);

    int questionAnswer = firstNumber;
    String questionString = "Find  𝑥  such that  𝑥 + $secondNumber = ${firstNumber + secondNumber}";

    return MathQuestion(question: questionString, type: "math", answer: questionAnswer);
  }

  MathQuestion generateSimpleArithmeticQuestion() {
    
    List<String> operations = ["+", "-"];

    int firstNumber = random.nextInt(20);
    int secondNumber = random.nextInt(20);
    String operation = operations[random.nextInt(operations.length)];

    int questionAnswer = operation == "+" ? firstNumber + secondNumber : firstNumber - secondNumber;
    String questionString = "$firstNumber $operation $secondNumber = ?";
  
    return MathQuestion(question: questionString, type: "math", answer: questionAnswer);
  }
}