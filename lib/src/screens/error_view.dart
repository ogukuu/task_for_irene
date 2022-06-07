import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.errorViewTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ElevatedButton(onPressed: _onPressed, child: Text("send Push")),
          Divider(),
          ElevatedButton(onPressed: _stop, child: Text("delete all Push"))
        ],
      ),
    );
  }
}

void _onPressed() {
  var push = GlobalVar.appController.push;
  var dateTime = DateTime.now();
  for (int i = 1; i < 10; i++) {
    push.showScheduledNotification(
        scheduledDate: dateTime,
        id: i,
        title: "showScheduledNotification: $i",
        body: "showScheduledNotification $i",
        secondDelay: 10);
  }
}

void _stop() {
  GlobalVar.appController.push.stopAllNotification();
}
