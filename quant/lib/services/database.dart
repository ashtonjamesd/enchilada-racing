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

  Future<void> incrementExperiencePoints(String userId, int amount) async {
    try 
    {
      await userCollection.doc(userId).update({
        'experiencePoints': FieldValue.increment(amount),
      });
    } 
    catch (exception) 
    {
      print('Error incrementing experience points: $exception');
    }
  }

  Future<void> incrementGamesPlayed(String userId) async {
    try 
    {
      await userCollection.doc(userId).update({
        'gamesPlayed': FieldValue.increment(1),
      });
    } 
    catch (exception) 
    {
      print('Error incrementing games played: $exception');
    }
  }

    Future<void> incrementLevel(String userId) async {
    try 
    {
      await userCollection.doc(userId).update({
        'level': FieldValue.increment(1),
      });
    } 
    catch (exception) 
    {
      print('Error incrementing level: $exception');
    }
  }

    Future<void> resetExperience(String userId) async {
    try 
    {
      await userCollection.doc(userId).update({
        'experiencePoints': 0,
      });
    } 
    catch (exception) 
    {
      print('Error resetting experience: $exception');
    }
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