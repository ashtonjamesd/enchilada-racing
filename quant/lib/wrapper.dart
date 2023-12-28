import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quant/models/quant_user.dart';
import 'package:quant/views/home.dart';
import 'package:quant/views/sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<QuantUser?>(context);
    
    if (user == null)
    {
      return const SignIn();
    }
    else
    {
      return const Home();
    }
  }
}