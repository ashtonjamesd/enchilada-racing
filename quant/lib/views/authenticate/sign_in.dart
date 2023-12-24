import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quant/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            dynamic result = await _auth.SignInAnon();

            if (result == null)
            {
              print("login failed");
            }
            else
            {
              print("login successful: $result");
            }
          },
          child: Text("Login Anonymously"),
        ),
      ),
    );
  }
}