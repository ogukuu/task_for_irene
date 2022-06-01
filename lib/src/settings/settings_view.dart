import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../app_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsViewTitle),
      ),
      body: Column(children: [
        _ThemeModeSetting(controller: controller),
        const Divider(
          height: 100,
        ),
        _DangerButton(controller: controller)
      ]),
    );
  }
}

class _ThemeModeSetting extends StatelessWidget {
  const _ThemeModeSetting({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButton<ThemeMode>(
        value: controller.themeMode,
        onChanged: controller.updateThemeMode,
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
  const _DangerButton({Key? key, required this.controller}) : super(key: key);
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber.shade900)),
        onPressed: (() {
          controller.clear();
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
