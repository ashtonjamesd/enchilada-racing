import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/sign_in.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();

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
                      "SIGN UP",
                      style: TextStyle(
                        color: textColour,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          validator: (text) => text!.isEmpty ? 'Email required' : null,
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
                      ),
                      TextFormField(
                        validator: (text) => text!.length < 8 ? "Password must be 8 characters or more" : null,
                        onChanged: (text){
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
                    ],
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
                          if (_formKey.currentState!.validate())
                          {
                            
                          }
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
                    onPressed: () async {
                        
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
                child: const Text(
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