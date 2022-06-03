import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

class AddTaskFloatingActionButton extends FloatingActionButton {
  AddTaskFloatingActionButton({Key? key, required BuildContext context})
      : super(
            elevation: 2,
            key: key,
            onPressed: () {
              Navigator.restorablePushNamed(context, NavRoute.addTask);
            },
            child: const Icon(Icons.add_task),
            tooltip:
                AppLocalizations.of(context)!.myFloatingActionButtonTooltip);
}
