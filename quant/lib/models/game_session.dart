class GameSession{
  String type;
  int correctAnswers;
  int incorrectAnswer;
  String time;
  DateTime dateTime;

  GameSession({
    required this.type, 
    required this.correctAnswers, 
    required this.incorrectAnswer, 
    required this.time,
    required this.dateTime,
  });
}