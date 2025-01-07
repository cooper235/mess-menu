import 'package:flutter/material.dart';

class Academics extends StatefulWidget {
  final bool isGuest;
  const Academics({super.key, required this.isGuest});

  @override
  State<Academics> createState() => _AcademicsState();
}

class _AcademicsState extends State<Academics> {
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
