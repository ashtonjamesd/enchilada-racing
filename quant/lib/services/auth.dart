import 'package:firebase_auth/firebase_auth.dart';
import 'package:quant/models/user.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;

  QuantUser? createQuantUser(User? user) => user != null ? QuantUser(
                                                            userId: user.uid, 
                                                            level: 1,
                                                            experiencePoints: 0,
                                                            questionsAnswered: 0,
                                                            correctQuestions: 0) : null;

  bool checkIfUserIsLoggedIn() => auth.currentUser != null ? true : false; // not being used

  String? returnCurrentUser() => auth.currentUser?.uid;

  Future? quantSignOutCurrentUser() async 
  {
    try
    {
      return await auth.signOut();
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }

  Future quantSignUpWithEmailAndPassword(String email, String password) async
  {
    try
    {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;

      return createQuantUser(firebaseUser); // database stuff later
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }

  Future? quantSignInWithEmailAndPassword(String email, String password) async
  {
    try
    {
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);  
      return result;
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }
}