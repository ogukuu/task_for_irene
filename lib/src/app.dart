import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';
import 'package:task_for_irene/src/screens/add_task_view.dart';
import 'package:task_for_irene/src/screens/tasks_view.dart';
import 'screens/calendar_view.dart';
import 'app_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appController}) : super(key: key);

  final AppController appController;
  final CalendarController calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: appController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                return getView(routeSettings.name);
              },
            );
          },
        );
      },
    );
  }

  Widget getView(String? route) {
    switch (route) {
      case AddTaskView.routeName:
        return AddTaskView(controller: appController);
      case SettingsView.routeName:
        return SettingsView(controller: appController);
      case TasksView.routeName:
        return TasksView(controller: appController);
      case CalendarView.routeName:
      default:
        return CalendarView(
          calendarController: calendarController,
          controller: appController,
        ); //const SampleItemListView();
    }
  }
}
