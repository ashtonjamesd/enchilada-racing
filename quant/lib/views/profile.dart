import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/user.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/services/database.dart';

class Profile extends StatelessWidget {
  Profile({Key? key});

  AuthService auth = AuthService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColour,
      appBar: AppBar(
        backgroundColor: containerColour,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 200,
          decoration: const BoxDecoration(
            color: containerColour,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<QuantUser?>(
                      future: database.quantGetUserDetails(auth.returnCurrentUser()!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text(
                            "Loading user details",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          );
                        } 
                        else if (snapshot.hasError) 
                        {
                          return Text('Error: ${snapshot.error}');
                        } 
                        else 
                        {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.title.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 4),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.2, 
                                  height: 2.5,
                                  child: LinearProgressIndicator(
                                    value: snapshot.data!.experiencePoints / 10, // 10 is the next level boundary
                                    color: const Color.fromARGB(255, 87, 87, 204), 
                                    backgroundColor: Colors.grey, 
                                  ),
                                ),
                              ),
                              Text(
                                "LEVEL ${snapshot.data!.level}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
