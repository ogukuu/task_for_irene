import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/push/notificationservice.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.errorViewTitle),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(AppLocalizations.of(context)!.errorViewMessage))),
    );
  }
}

void _onPressed() {
  showScheduledNotification(
      id: 1,
      title: "title",
      body: "body",
      payload: "pl",
      scheduledDate: DateTime.now(),
      secondDelay: 10);
  showScheduledNotification(
      id: 2,
      title: "title",
      body: "body",
      payload: "pl",
      scheduledDate: DateTime.now(),
      secondDelay: 15);
}
