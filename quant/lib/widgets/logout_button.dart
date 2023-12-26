import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/sign_in.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({super.key});

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try 
        {
          await auth.quantSignOutCurrentUser();
          print("Logged out with: \t\t${FirebaseAuth.instance.currentUser?.uid}"); // should be null
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
        } 
        catch (exception) 
        {
          print("Error logging out: $exception");
        }
      },
      child: const Icon(
        Icons.logout,
        color: Colors.black,
      ),
    );
  }
}
