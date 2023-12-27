import 'package:firebase_auth/firebase_auth.dart';

class QuantUser{

  final String userId;
  final String username;
  final String title;

  final int level;
  final int experiencePoints;

  final int questionsAnswered;

  QuantUser({required this.username, required this.questionsAnswered, required this.title, required this.level, required this.experiencePoints, required this.userId});

  void createQuantUser(User? user) {}
}