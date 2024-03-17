import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskland/extensions/datetime_localization.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/types/task_importance.dart';

class TaskCard extends StatefulWidget {
  final Future<Task?> task;

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
    return FutureBuilder(
        future: widget.task,
        builder: (context, snapshot) {
          final hasExtraData = snapshot.data?.date != null ||
              snapshot.data?.notification != null ||
              snapshot.data?.importance != null;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: checked,
                onChanged: snapshot.hasData
                    ? (val) => changeChecked(snapshot.data!, val)
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      snapshot.data?.name ?? "...",
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
                          if (snapshot.data?.date != null) ...[
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(snapshot.data!.date!.localizedDate(context)),
                            const SizedBox(width: 12),
                          ],
                          if (snapshot.data?.notification != null) ...[
                            const Icon(
                              Icons.alarm_rounded,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(snapshot.data!.notification!.toString()),
                            const SizedBox(width: 12),
                          ],
                          if (snapshot.data?.importance != null) ...[
                            const Icon(
                              Icons.flag_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(getImportanceText(snapshot.data!.importance!)),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        });
  }

  String getImportanceText(TaskImportance importance) {
    return switch (importance) {
      TaskImportance.p1 => "P1",
      TaskImportance.p2 => "P2",
      TaskImportance.p3 => "P3",
      TaskImportance.p4 => "P4",
    };
  }

  void changeChecked(Task task, bool? isChecked) {
    setState(() {
      checked = isChecked;
    });

    if (isChecked == true) {
      deleteTimer = Timer(
        const Duration(seconds: 3),
        () => task.delete(),
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
