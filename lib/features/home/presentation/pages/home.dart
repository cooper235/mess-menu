import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isGuest;
  final Map<String, dynamic>? user;
  const HomePage({super.key, required this.isGuest, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const []),
    );
  }
}
