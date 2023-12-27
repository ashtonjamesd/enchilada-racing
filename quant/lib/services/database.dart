import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({required this.uid});


  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  Future updateUserData(String userId, int level, int experiencePoints, int questionsAnswered) async
  {
    return await userCollection.doc(uid).set({
      'userId' : userId,
      'level' : level,
      'experiencePoints' : experiencePoints,
      'questionsAnswered' : questionsAnswered,
    });
  }

  Stream<QuerySnapshot> get users
  {
    return userCollection.snapshots();
  }
}