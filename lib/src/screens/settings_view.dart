import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/settings/settings.dart';
import 'package:task_for_irene/src/utilits/fix.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.settings}) : super(key: key);

  final Settings settings;

  void selectTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
        context: context, initialTime: settings.notificationTriggerTime);
    GlobalVar.appController.updateNotificationTriggerTime(selected);
  }

  @override
  Widget build(BuildContext context) {
    final double indent = MediaQuery.of(context).size.width / 12;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.settingsViewTitle),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _ThemeModeSetting(themeMode: settings.themeMode),
        Divider(
          thickness: 1,
          indent: indent,
          endIndent: indent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${AppLocalizations.of(context)!.settingsViewNotificationTitle}${getHHMMTimeOfDay(settings.notificationTriggerTime)}",
            textScaleFactor: 1.2,
          ),
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
                child: Text(AppLocalizations.of(context)!
                    .settingsViewNotificationButton),
              )),
        ),
      ]),
    );
  }
}

class _ThemeModeSetting extends StatelessWidget {
  const _ThemeModeSetting({Key? key, required this.themeMode})
      : super(key: key);

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButton<ThemeMode>(
        value: themeMode,
        onChanged: GlobalVar.appController.updateThemeMode,
        items: [
          DropdownMenuItem(
            value: ThemeMode.system,
            child: Text(AppLocalizations.of(context)!.settingsViewSystemTheme),
          ),
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text(AppLocalizations.of(context)!.settingsViewLightTheme),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text(AppLocalizations.of(context)!.settingsViewDarkTheme),
          )
        ],
      ),
    );
  }
}
