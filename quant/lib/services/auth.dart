import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future SignInAnon() async
  {
    try
    {
      return (await _auth.signInAnonymously()).user;
    }
    catch (exception)
    {
      print(exception.toString());
      return null;
    }
  }
}