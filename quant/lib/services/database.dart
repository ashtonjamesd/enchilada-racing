import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quant/models/quant_user.dart';

class DatabaseService{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  Future updateUserData(String userId, String username, int level, int experiencePoints, int questionsAnswered, String title) async
  {
    return await userCollection.doc(userId).set({
      'userId' : userId,
      'username' : username,
      'level' : level,
      'experiencePoints' : experiencePoints,
      'problemsSolved' : questionsAnswered,
      'title' : title,
      'problemSolverAchievement' : 0
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

  Future<void> incrementProblemsSolved(String userId) async {
    try 
    {
      await userCollection.doc(userId).update({
        'problemsSolved': FieldValue.increment(1),
      });
    } 
    catch (exception) 
    {
      print('Error incrementing problems solved: $exception');
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

  Future<void> checkForAchievements(String userId) async 
  {
    try 
    {
      DocumentSnapshot userData = await userCollection.doc(userId).get();

      if (userData.exists && userData.data() != null) 
      {
        int problemsSolved = userData.get(["problemsSolved"]);

        if (problemsSolved > 20) 
        {
          await userCollection.doc(userId).update({
            'problemSolverAchievement': 1,
            //I/flutter (13123): Error adding achievement: 
            //'package:cloud_firestore_platform_interface/src/platform_interface/platform_interface_document_snapshot.dart': 
            //Failed assertion: line 77 pos 7: 'field is String || field is FieldPath': 
            //Supported [field] types are [String] and [FieldPath]
          });
        }
      }
    } 
    catch (exception) 
    {
      print('Error adding achievement: $exception');
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
        int problemsSolved = (documentSnapshot.data() as Map<String, dynamic>?)?['problemsSolved'];
        String title = (documentSnapshot.data() as Map<String, dynamic>?)?['title'];

        QuantUser user = QuantUser(username: username, 
                                    problemsSolved: problemsSolved, 
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