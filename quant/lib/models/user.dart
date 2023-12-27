class QuantUser{

  final String userId;
  //final String userName;
  //final String email; might not need this but try anyway

  final int level;
  final int experiencePoints;

  final int questionsAnswered;

  QuantUser({required this.questionsAnswered, required this.level, required this.experiencePoints, required this.userId});
}