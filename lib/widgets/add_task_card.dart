import 'package:flutter/material.dart';
import 'package:taskland/extensions/color_scheme_direct_access.dart';
import 'package:taskland/extensions/datetime_localization.dart';
import 'package:taskland/services/storage.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/types/task_importance.dart';

class AddTaskCard extends StatefulWidget {
  const AddTaskCard({super.key});

  @override
  State<AddTaskCard> createState() => _AddTaskCardState();
}

class _AddTaskCardState extends State<AddTaskCard> {
  final textEditingController = TextEditingController();

  DateTime? selectedDate;
  TaskImportance? importance;

  bool sendTaskEnabled = false;

  // TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Görevinizi yazın...',
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    controller: textEditingController,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  iconSize: 18,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      context.colorScheme.primary,
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      context.colorScheme.onPrimary,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                    ),
                  ),
                  onPressed: () => addTask(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                InputChip(
                  label: Text(selectedDate?.localizedDate(context) ?? "Tarih"),
                  avatar: const Icon(Icons.calendar_today_rounded),
                  onPressed: () => selectDate(context),
                  onDeleted: selectedDate != null ? removeDate : null,
                ),
                const SizedBox(width: 8),
                // TODO: Implement this back later when notification system
                // is ready.

                // InputChip(
                //   label: Text(_selectedTime?.format(context) ?? "Bildirim"),
                //   avatar: const Icon(Icons.alarm_rounded),
                //   onPressed: () => selectTime(context),
                // ),
                const SizedBox(width: 8),
                InputChip(
                  label: Text(importance?.name.toUpperCase() ?? "Önem"),
                  avatar: const Icon(Icons.flag_outlined),
                  onPressed: () => showImportanceDialog(context),
                  onDeleted: importance != null ? removeImportance : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> showImportanceDialog(BuildContext context) async {
    List<Widget> widgets = [];

    widgets.add(
      const Text("Yüksek numaralar daha büyük önceliği temsil eder."),
    );

    widgets.addAll(
      TaskImportance.values
          .map(
            (importance) => RadioListTile<TaskImportance>(
              title: Text(importance.name.toUpperCase()),
              value: importance,
              groupValue: this.importance,
              onChanged: (value) {
                setState(() {
                  this.importance = value;
                });
                Navigator.pop(context);
              },
            ),
          )
          .toList(),
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Önem"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: "Görev tarihi",
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void removeDate() {
    setState(() {
      selectedDate = null;
    });
  }

  void removeImportance() {
    setState(() {
      importance = null;
    });
  }

  Future<void> addTask(BuildContext context) async {
    if (textEditingController.text.isEmpty) return;

    await StorageService.tasksBox.add(
      Task()
        ..name = textEditingController.text
        ..date = selectedDate
        ..importance = importance,
    );

    if (context.mounted) Navigator.pop(context);
  }

  // TODO: Implement this back later when notification system is ready.

  // Future<void> selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked;
  //     });
  //   }
  // }
}
