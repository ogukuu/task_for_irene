import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/task/task.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

import '../utilits/fix.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key, this.startDate}) : super(key: key);

  final DateTime? startDate;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  String? title;
  String? description;
  DateTime? dueDate;
  TimeOfDay? dueTime;
  String reminderFrequency = ReminderFrequency.week;

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

  String? getDueDateText() {
    if (dueDate == null) return null;
    return getDDMMYYYY(dueDate!);
  }

  String? getDueTimeText() {
    if (dueTime == null) return null;
    return getHHMMTimeOfDay(dueTime!);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startDate != null) {
      dueDate = widget.startDate;
      if (dueDate!.hour != 0 || dueDate!.minute != 0) {
        dueTime = TimeOfDay(hour: dueDate!.hour, minute: dueDate!.minute);
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.addTaskViewTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            TextFormField(
              onChanged: ((value) {
                title = value;
              }),
              decoration: InputDecoration(
                  label:
                      Text(AppLocalizations.of(context)!.addTaskViewTaskTitle)),
            ),

            // description
            TextFormField(
              onChanged: ((value) {
                description = value;
              }),
              maxLines: 3,
              decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!
                      .addTaskViewTaskDescription)),
            ),
            const Divider(),

            // due date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(1),
                      backgroundColor: elevatedButtonBackgroundFix(context)),
                  onPressed: () {
                    selectDate(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getDueDateText() ??
                        AppLocalizations.of(context)!
                            .addTaskViewTaskSelectDueDate),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(1),
                      backgroundColor: elevatedButtonBackgroundFix(context)),
                  onPressed: () {
                    selectTime(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getDueTimeText() ??
                        AppLocalizations.of(context)!
                            .addTaskViewTaskSelectDueTime),
                  )),
            ),
            const Divider(),

            // reminder frequency
            Text(
              AppLocalizations.of(context)!.addTaskViewReminderFrequencyLabel,
              textScaleFactor: 1.1,
            ),
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

            // save button
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
                            title!,
                            description!,
                            getDue(dueDate!, dueTime),
                            reminderFrequency));
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.addTaskViewSave,
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
    if (title == null) {
      error += AppLocalizations.of(context)!.addTaskViewErrorTitle;
    }
    if (description == null) {
      if (error.isNotEmpty) error += "\n";
      error += AppLocalizations.of(context)!.addTaskViewErrorDescription;
    }
    if (dueDate == null) {
      if (error.isNotEmpty) error += "\n";
      error += AppLocalizations.of(context)!.addTaskViewErrorDueDate;
    } else {
      if (getDue(dueDate!, dueTime).isBefore(DateTime.now())) {
        if (error.isNotEmpty) error += "\n";
        error += AppLocalizations.of(context)!.addTaskViewErrorLate;
      }
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
