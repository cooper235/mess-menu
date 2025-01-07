import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  final bool isGuest;
  const Notifications({super.key, required this.isGuest});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
