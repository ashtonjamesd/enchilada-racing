import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/views/home.dart';
import 'package:quant/views/sign_up.dart';
import 'package:quant/widgets/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String errorMessage = "";
  
  @override
  Widget build(BuildContext context) {
    return loading == true ? const LoadingIcon() : Scaffold(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          validator: (text) => text!.isEmpty ? "Email required" : null,
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
                        validator: (text) => text!.isEmpty ? "Password required" : null,
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
                          if (_formKey.currentState!.validate()){
                            
                            setState(() => loading = true);
                            dynamic result = await auth.quantSignInWithEmailAndPassword(email, password);
                            print("Signed in with ${auth.returnCurrentUser()}");
                            if (result == null)
                            {
                              setState(() {
                                errorMessage = "Invalid email or password";
                                loading = false;
                              });
                            }
                            else
                            {
                              setState(() {
                                errorMessage = "";
                                loading = false;
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                            }
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
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
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
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextButton(
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
              ),
            ],
          ),
        ],
      )
    );
  }
}