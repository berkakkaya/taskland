import 'package:flutter/material.dart';
import 'package:taskland/extensions/datetime_localization.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/types/task_importance.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool? isChecked = false;

  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 40,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        children: [
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: changeChecked),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Görev başlığı',
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                  textCapitalization: TextCapitalization.sentences,
                  controller: titleController,
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  onTapOutside: onTitleEditDone,
                  onSubmitted: (val) => onTitleEditDone(null),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ListTile(
            title: const Text('Görev Tarihi'),
            subtitle:
                Text(widget.task.date?.localizedDate(context) ?? "Seçilmedi"),
            leading: const Icon(Icons.calendar_month_rounded),
            trailing: widget.task.date == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    tooltip: "Görev tarihini temizle",
                    onPressed: clearDate,
                  ),
            onTap: getNewDate,
          ),
          ListTile(
            title: const Text('Görev Önemi'),
            subtitle:
                Text(widget.task.importance?.name.toUpperCase() ?? "Seçilmedi"),
            leading: const Icon(Icons.flag_outlined),
            trailing: widget.task.importance == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    tooltip: "Önemi temizle",
                    onPressed: removeImportance,
                  ),
            onTap: () => selectNewImportance(context),
          ),
        ],
      ),
    );
  }

  void clearDate() {
    widget.task.date = null;
    widget.task.save();
    setState(() {});
  }

  Future<void> getNewDate() async {
    final newDate = await showDatePicker(
      context: context,
      helpText: "Görev Tarihi",
      initialDate: widget.task.date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) {
      widget.task.date = newDate;
      widget.task.save();
      setState(() {});
    }
  }

  Future<void> selectNewImportance(BuildContext context) async {
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
              groupValue: widget.task.importance,
              onChanged: (value) {
                setState(() {
                  widget.task.importance = value;
                  widget.task.save();
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
          title: const Text("Görev Önemi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        );
      },
    );
  }

  void removeImportance() {
    widget.task.importance = null;
    widget.task.save();
    setState(() {});
  }

  @override
  void dispose() {
    titleController.dispose();

    if (isChecked == true) {
      widget.task.delete();
    }

    super.dispose();
  }

  void onTitleEditDone(PointerDownEvent? event) {
    if (titleController.text.isEmpty) {
      titleController.text = widget.task.name!;
    } else if (titleController.text != widget.task.name) {
      widget.task.name = titleController.text;
      widget.task.save();
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void changeChecked(bool? val) {
    setState(() {
      isChecked = val;
    });
  }
}
