import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final bool isGuest;
  const Profile({super.key, required this.isGuest});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(),
      ),
    );
  }
}
