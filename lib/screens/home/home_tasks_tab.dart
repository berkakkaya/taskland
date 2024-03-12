import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskland/consts/illustrations.dart';
import 'package:taskland/services/storage.dart';

class HomeTasksTab extends StatefulWidget {
  const HomeTasksTab({super.key});

  @override
  State<HomeTasksTab> createState() => _HomeTasksTabState();
}

class _HomeTasksTabState extends State<HomeTasksTab> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: StorageService.tasksBox.listenable(),
      builder: (context, box, widget) {
        if (box.isEmpty) {
          return _getEmptyPage(context);
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: box.length,
          itemBuilder: (context, index) {
            return const Placeholder();
          },
        );
      },
    );
  }

  Padding _getEmptyPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            child: svgNature,
          ),
          const SizedBox(height: 32),
          Text(
            "Listeniz boş",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "Hemen sağ alttaki butondan yeni görevler eklemeye başlayın.",
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
