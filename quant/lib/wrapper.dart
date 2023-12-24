import 'package:flutter/widgets.dart';
import 'package:quant/views/authenticate/authenticate.dart';
import 'package:quant/views/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  final bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    
    if (loggedIn)
    {
      return Home();
    }
    else
    {
    return Authenticate();
    }
  }
}