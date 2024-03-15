import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskland/consts/illustrations.dart';
import 'package:taskland/services/storage.dart';
import 'package:taskland/widgets/task_card.dart';

class HomeTasksTab extends StatefulWidget {
  const HomeTasksTab({super.key});

  @override
  State<HomeTasksTab> createState() => _HomeTasksTabState();
}

class _HomeTasksTabState extends State<HomeTasksTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 32),
          child: SearchBar(
            hintText: "Görevlerde ara",
            trailing: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search_rounded),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: StorageService.tasksBox.listenable(),
          builder: (context, box, widget) {
            if (box.isEmpty) {
              return Expanded(child: _getEmptyPage(context));
            }

            return Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: box.getAt(index),
                  );
                },
              ),
            );
          },
        ),
      ],
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
