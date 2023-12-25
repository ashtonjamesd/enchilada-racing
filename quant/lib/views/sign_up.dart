import 'package:flutter/material.dart';
import 'package:quant/models/user.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/authenticate.dart';
import 'package:quant/views/home.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final AuthService _auth = AuthService();

  final Color primarydarkBlue = const Color.fromARGB(255, 67, 69, 125);
  final Color secondaryDarkBlue = const Color.fromARGB(255, 134, 136, 209);
  final Color textColour = const Color.fromARGB(255, 61, 61, 61);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 320,
            height: 720,
            color: Colors.white,// make this check if it is on a desktop monitor if so make it grey, else on a mobile make it white
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 160),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: textColour,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: "EMAIL",
                    labelStyle: TextStyle(
                      color: textColour,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height:16),
                TextField(
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "PASSWORD",
                    labelStyle: TextStyle(
                      color: textColour,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 24),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          primarydarkBlue,
                          secondaryDarkBlue,
                        ]
                      )
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                    
                        },
                        child: const Icon(
                          Icons.login,
                          size: 18,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onHover: (isHovering) {
                      if (isHovering){
                  
                      }
                    },
                    onPressed: () async {
                        AnonymousUser? result = await _auth.signInAnon();
                        
                        if (result != null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                          print("Signed in anonymously with:  ${result.userId}");
                        }
                        else
                        {
                          print("Error: Unable to sign in");
                        }
                    },
                    child: Text(
                      "or enter anonymously",
                        style: TextStyle(
                        color: textColour.withOpacity(0.8), 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: textColour,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Authenticate()));
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: textColour,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}