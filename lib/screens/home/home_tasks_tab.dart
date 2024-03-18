import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskland/consts/illustrations.dart';
import 'package:taskland/services/storage.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/widgets/task_card.dart';

class HomeTasksTab extends StatefulWidget {
  const HomeTasksTab({super.key});

  @override
  State<HomeTasksTab> createState() => _HomeTasksTabState();
}

class _HomeTasksTabState extends State<HomeTasksTab> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SearchBar(
            hintText: "Görevlerde ara",
            trailing: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search_rounded),
              ),
            ],
            onChanged: updateSearchQuery,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: StorageService.tasksBox.listenable(),
          builder: (context, box, widget) {
            if (box.isEmpty) {
              return Expanded(child: _getEmptyPage(context));
            }

            List<Task>? searchResults;

            if (searchQuery.isNotEmpty) {
              searchResults = box.values.where((task) {
                return task.name!
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
              }).toList();
            }

            return Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemCount:
                    searchResults != null ? searchResults.length : box.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    key: ObjectKey(
                      searchResults != null
                          ? searchResults.elementAt(index)
                          : box.getAt(index)!,
                    ),
                    task: searchResults != null
                        ? searchResults.elementAt(index)
                        : box.getAt(index)!,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void updateSearchQuery(val) {
    setState(() {
      searchQuery = val;
    });
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
