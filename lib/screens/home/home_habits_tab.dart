import 'package:flutter/material.dart';
import 'package:taskland/consts/illustrations.dart';

class HomeHabitsTab extends StatefulWidget {
  const HomeHabitsTab({super.key});

  @override
  State<HomeHabitsTab> createState() => _HomeHabitsTabState();
}

class _HomeHabitsTabState extends State<HomeHabitsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            child: svgHabit,
          ),
          const SizedBox(height: 32),
          Text(
            "Alışkanlıklarınızı takip edin",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "Bu özellik uygulamanın sonraki sürümlerinde getirilecek.",
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
