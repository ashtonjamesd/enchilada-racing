import 'package:firebase_auth/firebase_auth.dart';
import 'package:quant/models/user.dart';
import 'package:quant/services/database.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;

  QuantUser? createQuantUser(User? user, String username) => user != null ? QuantUser(
                                                            userId: user.uid, 
                                                            username: username,
                                                            title: "Apprentice",
                                                            level: 1,
                                                            experiencePoints: 0,
                                                            questionsAnswered: 0) : null;

  bool checkIfUserIsLoggedIn() => auth.currentUser != null ? true : false; // not being used

  User? returnCurrentUser() => auth.currentUser;

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

  Future quantSignUpWithEmailAndPassword(String email, String password, String username) async
  {
    try
    {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;

      await DatabaseService().updateUserData(firebaseUser!.uid, username, 1, 0, 0, "apprentice");
      return createQuantUser(firebaseUser, username);
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

  // Stream<QuantUser?> get user =>
  //     auth.authStateChanges().map(createQuantUser);
}