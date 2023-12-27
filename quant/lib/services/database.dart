import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quant/models/user.dart';

class DatabaseService{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  Future updateUserData(String userId, String username, int level, int experiencePoints, int questionsAnswered, String title) async
  {
    return await userCollection.doc(userId).set({
      'userId' : userId,
      'username' : username,
      'level' : level,
      'experiencePoints' : experiencePoints,
      'questionsAnswered' : questionsAnswered,
      'title' : title,
    });
  }

Future<QuantUser?> quantGetUserDetails(String userId) async {
    try {
      DocumentSnapshot<Object?> documentSnapshot =
          await userCollection.doc(userId).get();

      if (documentSnapshot.exists) 
      {
        String userId = (documentSnapshot.data() as Map<String, dynamic>?)?['userId'];
        String username = (documentSnapshot.data() as Map<String, dynamic>?)?['username'];
        int level = (documentSnapshot.data() as Map<String, dynamic>?)?['level'];
        int experiencePoints = (documentSnapshot.data() as Map<String, dynamic>?)?['experiencePoints'];
        int questionsAnswered = (documentSnapshot.data() as Map<String, dynamic>?)?['questionsAnswered'];
        String title = (documentSnapshot.data() as Map<String, dynamic>?)?['title'];

        QuantUser user = QuantUser(username: username, 
                                    questionsAnswered: questionsAnswered, 
                                    level: level, 
                                    title: title,
                                    experiencePoints: experiencePoints, 
                                    userId: userId);
        return user;
        } 
        else 
        {
        print('User not found for ID: $userId');
      }
    } catch (exception) {
      print('Error retrieving user data: $exception');
    }
    return null;
  }

  Stream<QuerySnapshot> get users
  {
    return userCollection.snapshots();
  }
}