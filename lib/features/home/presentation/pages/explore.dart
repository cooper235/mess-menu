import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  final bool isGuest;
  const Explore({super.key, required this.isGuest});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
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
