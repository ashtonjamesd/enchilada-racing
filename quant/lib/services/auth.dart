import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future SignInAnon() async
  {
    try
    {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }
}