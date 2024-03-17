import 'package:flutter/material.dart';
import 'package:taskland/screens/home/home_habits_tab.dart';
import 'package:taskland/screens/home/home_settings_tab.dart';
import 'package:taskland/screens/home/home_tasks_tab.dart';
import 'package:taskland/widgets/add_task_card.dart';

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
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: "Görevler",
          ),
          NavigationDestination(
            icon:
                Icon(currentPage == 1 ? Icons.spa_rounded : Icons.spa_outlined),
            label: "Alışkanlıklar",
          ),
          NavigationDestination(
            icon: Icon(currentPage == 2
                ? Icons.settings_rounded
                : Icons.settings_outlined),
            label: "Ayarlar",
          ),
        ],
      ),
      floatingActionButton: _getFab(context),
      body: SafeArea(
        child: AnimatedSwitcher(
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
      ),
    );
  }

  Widget? _getFab(BuildContext context) {
    if (currentPage == 2) {
      return null;
    }

    final Icon icon = currentPage == 0
        ? const Icon(Icons.edit_outlined, key: ValueKey(0))
        : const Icon(Icons.add_rounded, key: ValueKey(1));

    final String hint = currentPage == 0 ? "Görev ekle" : "Alışkanlık ekle";

    return FloatingActionButton(
      onPressed: () => _triggerFab(context),
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

  void _triggerFab(BuildContext context) {
    if (currentPage == 0) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddTaskCard(),
      );

      return;
    }
  }

  void _onNewTabTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
