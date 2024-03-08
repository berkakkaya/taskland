import 'package:flutter/material.dart';

class HomeTasksTab extends StatefulWidget {
  const HomeTasksTab({super.key});

  @override
  State<HomeTasksTab> createState() => _HomeTasksTabState();
}

class _HomeTasksTabState extends State<HomeTasksTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Tasks"),
    );
  }
}
