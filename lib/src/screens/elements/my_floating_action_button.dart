import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyFloatingActionButton extends FloatingActionButton {
  MyFloatingActionButton(
      {Key? key, VoidCallback? onPressed, required BuildContext context})
      : super(
            key: key,
            onPressed: onPressed,
            child: const Icon(Icons.add_task),
            tooltip:
                AppLocalizations.of(context)!.myFloatingActionButtonTooltip);
}
