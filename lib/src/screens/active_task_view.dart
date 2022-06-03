import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/models/task.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

import '../utilits/fix.dart';

class ActiveTaskView extends StatefulWidget {
  ActiveTaskView({Key? key, required Task task}) : super(key: key) {
    localTask = task.getCopy();
  }

  late final Task localTask;

  @override
  State<ActiveTaskView> createState() => _ActiveTaskViewState();
}

class _ActiveTaskViewState extends State<ActiveTaskView> {
  late String title;

  String get description => widget.localTask.description;
  set description(String string) => widget.localTask.description = string;

  DateTime get dueDate => widget.localTask.dueDate;
  set dueDate(DateTime dateTime) => widget.localTask.dueDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dueTime.hour,
      dueTime.minute);

  TimeOfDay get dueTime => TimeOfDay(
      hour: widget.localTask.dueDate.hour,
      minute: widget.localTask.dueDate.minute);
  set dueTime(TimeOfDay timeOfDay) => widget.localTask.dueDate = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day,
      timeOfDay.hour,
      timeOfDay.minute);

  String get reminderFrequency => widget.localTask.reminderFrequency;
  set reminderFrequency(String string) =>
      widget.localTask.reminderFrequency = string;

  bool changed = false;

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2500));

    if (selected != null && selected != dueDate) {
      dueDate = selected;
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    title = widget.localTask.title;
    description = widget.localTask.description;
    dueDate = widget.localTask.dueDate;
    reminderFrequency = widget.localTask.reminderFrequency;

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
            _Title(
              title: title,
            ),
            const Divider(),
            _DescriptionField(
              description: description,
              onChanged: ((value) {
                setState(() {
                  description = value;
                  changed = true;
                });
              }),
            ),
            const Divider(),
            _DueDate(
                dueDate: dueDate,
                onPressedDate: () => selectDate(context),
                onPressedTime: () => selectTime(context)),
            const Divider(),
            _ReminderFrequrency(
                onChanged: (value) {
                  setState(() {
                    reminderFrequency = value!;
                  });
                },
                reminderFrequency: reminderFrequency),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor: elevatedButtonBackgroundFix(context)),
                    onPressed: tapOnSaveButton,
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

  void tapOnSaveButton() {
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
      GlobalVar.appController.update(widget.localTask);
      Navigator.pop(context);
    }
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
  const _Title({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.3,
          textAlign: TextAlign.center),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({Key? key, required this.description, this.onChanged})
      : super(key: key);

  final String description;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: description,
      onChanged: onChanged,
      maxLines: 3,
      decoration: InputDecoration(
          label: Text(
              AppLocalizations.of(context)!.activeTaskViewTaskDescription)),
    );
  }
}

class _DueDate extends StatelessWidget {
  const _DueDate(
      {Key? key,
      required this.dueDate,
      required this.onPressedDate,
      required this.onPressedTime})
      : super(key: key);

  final DateTime dueDate;
  final void Function()? onPressedDate;
  final void Function()? onPressedTime;
  TimeOfDay get dueTime =>
      TimeOfDay(hour: dueDate.hour, minute: dueDate.minute);

  @override
  Widget build(BuildContext context) {
    var dueTime = TimeOfDay(hour: dueDate.hour, minute: dueDate.minute);
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.activeTaskViewTaskDueDate),
        Row(
          children: [
            Text(AppLocalizations.of(context)!.activeTaskViewTaskDueDateDate),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(1),
                      backgroundColor: elevatedButtonBackgroundFix(context)),
                  onPressed: onPressedDate,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getDDMMYYYY(dueDate)),
                  )),
            ),
          ],
        ),

        //due time
        Row(
          children: [
            Text(AppLocalizations.of(context)!.activeTaskViewTaskDueDateTime),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(1),
                      backgroundColor: elevatedButtonBackgroundFix(context)),
                  onPressed: onPressedTime,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getHHMMTimeOfDay(dueTime)),
                  )),
            ),
          ],
        )
      ],
    );
  }
}

class _ReminderFrequrency extends StatelessWidget {
  const _ReminderFrequrency(
      {Key? key, required this.onChanged, required this.reminderFrequency})
      : super(key: key);
  final void Function(String?)? onChanged;
  final String reminderFrequency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            AppLocalizations.of(context)!.activeTaskViewReminderFrequencyLabel),
        DropdownButton<String>(
            isExpanded: true,
            value: reminderFrequency,
            onChanged: onChanged,
            items: [
              DropdownMenuItem(
                  value: ReminderFrequency.day,
                  child:
                      Text(AppLocalizations.of(context)!.reminderFrequencyDay)),
              DropdownMenuItem(
                  value: ReminderFrequency.week,
                  child: Text(
                      AppLocalizations.of(context)!.reminderFrequencyWeek)),
              DropdownMenuItem(
                  value: ReminderFrequency.month,
                  child: Text(
                      AppLocalizations.of(context)!.reminderFrequencyMonth))
            ]),
      ],
    );
  }
}
