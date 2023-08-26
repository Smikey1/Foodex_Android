import 'package:flutter/material.dart';

class WearOsDashboard extends StatefulWidget {
  const WearOsDashboard({super.key});

  @override
  State<WearOsDashboard> createState() => _WearOsDashboardState();
}

class _WearOsDashboardState extends State<WearOsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("Dashboard"),
        ),
      ),
    );
  }
}
