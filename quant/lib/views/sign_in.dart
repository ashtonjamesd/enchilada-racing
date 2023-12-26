import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/user.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/home.dart';
import 'package:quant/views/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  final AuthService auth = AuthService();

  String email = "";
  String password = "";

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
                const Padding(
                  padding: EdgeInsets.only(bottom: 32, top: 160),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                        color: textColour,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    labelText: "EMAIL",
                    labelStyle: TextStyle(
                      color: textColour,
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height:16),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "PASSWORD",
                    labelStyle: TextStyle(
                      color: textColour,
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 24),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          primarydarkBlue,
                          secondaryDarkBlue,
                        ]
                      )
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          //print("User after logging out (should be null): ${auth.returnCurrentUser()}");
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
                        AnonymousUser? result = await auth.signInAnon();
                        
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
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  color: textColour,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: const Text(
                  "Sign Up",
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