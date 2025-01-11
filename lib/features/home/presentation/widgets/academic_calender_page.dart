import 'package:flutter/material.dart';

class AcademicCalenderPage extends StatefulWidget {
  const AcademicCalenderPage({super.key});

  @override
  State<AcademicCalenderPage> createState() => _AcademicCalenderPageState();
}

class _AcademicCalenderPageState extends State<AcademicCalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text("Academic Calender",
            style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
      ),
    );
  }
}
