import 'package:flutter/material.dart';

class HomeSettingsTab extends StatefulWidget {
  const HomeSettingsTab({super.key});

  @override
  State<HomeSettingsTab> createState() => _HomeSettingsTabState();
}

class _HomeSettingsTabState extends State<HomeSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Settings"),
    );
  }
}
