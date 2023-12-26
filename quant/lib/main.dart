import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quant/views/sign_in.dart';

import 'utilities/firebase_options.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    );
  }
}