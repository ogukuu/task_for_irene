import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/models/task.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

import '../utilits/fix.dart';

class ActiveTaskView extends StatefulWidget {
  const ActiveTaskView({Key? key, required this.task}) : super(key: key);

  final Task? task;

  @override
  State<ActiveTaskView> createState() => _ActiveTaskViewState();
}

class _ActiveTaskViewState extends State<ActiveTaskView> {
  late Task? task;
  late String title;
  late String description;
  late DateTime dueDate;
  late TimeOfDay dueTime;
  late String reminderFrequency;
  bool changed = false;

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2500));
    if (selected != null && selected != dueDate) {
      setState(() {
        dueDate = selected;
      });
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selected != null && selected != dueTime) {
      setState(() {
        dueTime = selected;
      });
    }
  }

  String getDueDateText() {
    return getDDMMYYYY(dueDate);
  }

  String getDueTimeText() {
    return getHHMMTimeOfDay(dueTime);
  }

  @override
  Widget build(BuildContext context) {
    task = widget.task;
    if (task == null) return const Text("empty");
    title = task!.title;
    description = task!.description;
    dueDate = task!.dueDate;
    dueTime = TimeOfDay(hour: dueDate.hour, minute: dueDate.minute);
    reminderFrequency = task!.reminderFrequency;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.activeTaskViewTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            _Title(task: task!),
            const Divider(),

            // description
            TextFormField(
              initialValue: description,
              onChanged: ((value) {
                setState(() {
                  description = value;
                  changed = true;
                });
              }),
              maxLines: 3,
              decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!
                      .activeTaskViewTaskDescription)),
            ),

            const Divider(),

            // due date
            Text(AppLocalizations.of(context)!.activeTaskViewTaskDueDate),
            Row(
              children: [
                Text(AppLocalizations.of(context)!
                    .activeTaskViewTaskDueDateDate),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                          backgroundColor:
                              elevatedButtonBackgroundFix(context)),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(getDueDateText()),
                      )),
                ),
              ],
            ),

            //due time
            Row(
              children: [
                Text(AppLocalizations.of(context)!
                    .activeTaskViewTaskDueDateTime),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                          backgroundColor:
                              elevatedButtonBackgroundFix(context)),
                      onPressed: () {
                        selectTime(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(getDueTimeText()),
                      )),
                ),
              ],
            ),

            const Divider(),

            // reminder frequency
            Text(AppLocalizations.of(context)!
                .activeTaskViewReminderFrequencyLabel),
            DropdownButton<String>(
                isExpanded: true,
                value: reminderFrequency,
                onChanged: (value) {
                  setState(() {
                    reminderFrequency = value!;
                  });
                },
                items: [
                  DropdownMenuItem(
                      value: ReminderFrequency.day,
                      child: Text(
                          AppLocalizations.of(context)!.reminderFrequencyDay)),
                  DropdownMenuItem(
                      value: ReminderFrequency.week,
                      child: Text(
                          AppLocalizations.of(context)!.reminderFrequencyWeek)),
                  DropdownMenuItem(
                      value: ReminderFrequency.month,
                      child: Text(
                          AppLocalizations.of(context)!.reminderFrequencyMonth))
                ]),

            const Divider(),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor: elevatedButtonBackgroundFix(context)),
                    onPressed: () {
                      String error = _saveTest(context);
                      if (error != "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            error,
                            textAlign: TextAlign.center,
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                        ));
                      } else {
                        GlobalVar.appController.addTask(Task.newTask(
                            title,
                            description,
                            getDue(dueDate, dueTime),
                            reminderFrequency));
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.activeTaskViewSave,
                        textScaleFactor: 1.3,
                      ),
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }

  String _saveTest(BuildContext context) {
    String error = "";
    if (getDue(dueDate, dueTime).isBefore(DateTime.now())) {
      if (error.isNotEmpty) error += "\n";
      error += AppLocalizations.of(context)!.activeTaskViewErrorLate;
    }
    return error;
  }

  DateTime getDue(DateTime dueDate, TimeOfDay? dueTime) {
    return (dueTime == null)
        ? dueDate
        : DateTime(dueDate.year, dueDate.month, dueDate.day, dueTime.hour,
            dueTime.minute);
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(task.title,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.3,
          textAlign: TextAlign.center),
    );
  }
}
