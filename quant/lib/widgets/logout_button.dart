import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/authenticate.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({super.key});

  final AuthService auth = AuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        auth.logoutCurrentUser();
        print("Logged out with: \t\t${firebaseAuth.currentUser?.uid}");
        auth.logoutCurrentUser();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Authenticate()));
      },
      child: const Icon(
        Icons.logout,
        color: Colors.black,
      ),
    );
  }
}