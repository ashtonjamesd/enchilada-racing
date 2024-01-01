import 'package:flutter/material.dart';
import 'package:quant/globals.dart';
import 'package:quant/models/quant_user.dart';
import 'package:quant/services/auth.dart';
import 'package:quant/services/database.dart';
import 'dart:math';

class Profile extends StatelessWidget {
  Profile({super.key});

  final AuthService auth = AuthService();
  final DatabaseService database = DatabaseService();

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
          decoration: const BoxDecoration(
            color: containerColour,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: FutureBuilder<QuantUser?>(
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
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
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
                                Column(
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
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2.2,
                                        height: 3,
                                        child: LinearProgressIndicator(
                                          borderRadius: BorderRadius.circular(16),
                                          value: snapshot.data!.experiencePoints /
                                              calculateExperienceThreshold(snapshot.data!.level),
                                          color: const Color.fromARGB(255, 87, 87, 204),
                                          backgroundColor: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 100),
                                          child: Text(
                                            "LEVEL ${snapshot.data!.level}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.experiencePoints} / ${calculateExperienceThreshold(snapshot.data!.level)}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Container(
                        width: 280,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Problems Solved",
                            style: primaryFont(
                              color: const Color.fromARGB(255, 217, 217, 217),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${snapshot.data!.problemsSolved}",
                            style: primaryFont(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  num calculateExperienceThreshold(int level) {
    const double constant = 0.3;
    const double exponent = 2;

    var threshold = pow((level / constant), exponent);
    threshold = threshold.toInt();

    return threshold;
  }
}
