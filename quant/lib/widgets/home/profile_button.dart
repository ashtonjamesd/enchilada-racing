import 'package:flutter/material.dart';
import 'package:quant/views/profile.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
      },
      icon: const Icon(
        Icons.person_2_outlined,
        color: Colors.white,
      ),
    );
  }
}