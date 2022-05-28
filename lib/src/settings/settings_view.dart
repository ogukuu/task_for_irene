import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsViewTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButton<ThemeMode>(
          value: controller.themeMode,
          onChanged: controller.updateThemeMode,
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child:
                  Text(AppLocalizations.of(context)!.settingsViewSystemTheme),
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
      ),
    );
  }
}
