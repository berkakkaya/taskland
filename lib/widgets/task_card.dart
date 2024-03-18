import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskland/extensions/datetime_localization.dart';
import 'package:taskland/screens/tasks/task_detail_screen.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/types/task_importance.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool? checked = false;

  Timer? deleteTimer;

  @override
  Widget build(BuildContext context) {
    final hasExtraData = widget.task.date != null ||
        widget.task.notification != null ||
        widget.task.importance != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(value: checked, onChanged: (val) => changeChecked(val)),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => goToDetails(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.task.name!,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                if (hasExtraData) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.task.date != null) ...[
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(widget.task.date!.localizedDate(context)),
                        const SizedBox(width: 12),
                      ],
                      if (widget.task.notification != null) ...[
                        const Icon(
                          Icons.alarm_rounded,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(widget.task.notification!.toString()),
                        const SizedBox(width: 12),
                      ],
                      if (widget.task.importance != null) ...[
                        const Icon(
                          Icons.flag_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(getImportanceText(widget.task.importance!)),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getImportanceText(TaskImportance importance) {
    return switch (importance) {
      TaskImportance.p1 => "P1",
      TaskImportance.p2 => "P2",
      TaskImportance.p3 => "P3",
      TaskImportance.p4 => "P4",
    };
  }

  void changeChecked(bool? isChecked) {
    setState(() {
      checked = isChecked;
    });

    if (isChecked == true) {
      deleteTimer = Timer(
        const Duration(seconds: 3),
        () => widget.task.delete(),
      );

      return;
    }

    if (isChecked == false) {
      deleteTimer?.cancel();

      deleteTimer = null;
      return;
    }
  }
}
