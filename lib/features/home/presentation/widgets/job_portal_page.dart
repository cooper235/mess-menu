import 'package:flutter/material.dart';

class JobPortalPage extends StatefulWidget {
  const JobPortalPage({super.key});

  @override
  State<JobPortalPage> createState() => _JobPortalPageState();
}

class _JobPortalPageState extends State<JobPortalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title:
        Text("Job Portal", style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
      ),
    );
  }
}
