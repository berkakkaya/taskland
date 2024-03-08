import 'package:flutter/material.dart';
import 'package:taskland/screens/home/home_habits_tab.dart';
import 'package:taskland/screens/home/home_settings_tab.dart';
import 'package:taskland/screens/home/home_tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: _onNewTabTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: "Görevler",
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            label: "Alışkanlıklar",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Ayarlar",
          ),
        ],
      ),
      floatingActionButton: _getFab(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCirc,
        switchOutCurve: Curves.easeInCirc,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: <Widget>[
          const HomeTasksTab(key: ValueKey(0)),
          const HomeHabitsTab(key: ValueKey(1)),
          const HomeSettingsTab(key: ValueKey(2)),
        ][currentPage],
      ),
    );
  }

  Widget? _getFab() {
    if (currentPage == 2) {
      return null;
    }

    final Icon icon = currentPage == 0
        ? const Icon(Icons.edit_outlined, key: ValueKey(0))
        : const Icon(Icons.add_rounded, key: ValueKey(1));

    final String hint = currentPage == 0 ? "Görev ekle" : "Alışkanlık ekle";

    return FloatingActionButton(
      onPressed: () {},
      tooltip: hint,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCirc,
        switchOutCurve: Curves.easeInCirc,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: icon,
      ),
    );
  }

  void _onNewTabTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
