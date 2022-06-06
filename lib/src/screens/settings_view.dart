import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/settings/settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.settings}) : super(key: key);

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    final double indent = MediaQuery.of(context).size.width / 12;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context)!.settingsViewTitle),
      ),
      body: Column(children: [
        _ThemeModeSetting(themeMode: settings.themeMode),
        Divider(
          thickness: 1,
          indent: indent,
          endIndent: indent,
          height: 100,
        ),
        const _DangerButton(),
        Divider(
          thickness: 1,
          indent: indent,
          endIndent: indent,
          height: 100,
        ),
        const _TestErrorButton()
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

class _DangerButton extends StatelessWidget {
  const _DangerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber.shade900)),
        onPressed: (() {
          GlobalVar.appController.clear();
        }),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "DELETE ALL TASKS",
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 2,
          ),
        ));
  }
}

class _TestErrorButton extends StatelessWidget {
  const _TestErrorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber.shade900)),
        onPressed: (() {
          Navigator.restorablePushNamed(context, NavRoute.error);
        }),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Test Error View",
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 2,
          ),
        ));
  }
}
