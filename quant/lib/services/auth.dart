import 'package:firebase_auth/firebase_auth.dart';
import 'package:quant/models/user.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;

  AnonymousUser? createQuantUser(User? user) => user != null ? AnonymousUser(userId: user.uid) : null;

  bool checkIfUserIsLoggedIn() => auth.currentUser != null ? true : false; // not being used

  String? returnCurrentUser() => auth.currentUser?.uid;

  Future signInAnon() async
  {
    try
    {
      User? user = (await auth.signInAnonymously()).user;
      print("\nFirebase User: \t\t${user?.uid}\n");
    
      return createQuantUser(user);
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }

  Future logoutCurrentUser() async 
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
}