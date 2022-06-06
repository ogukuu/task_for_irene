import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarUtilits {
  static const int minYear = 2022;

  static bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }

  static int getDayInMonth(int month, int year) {
    switch (month) {
      case DateTime.january:
        return 31;
      case DateTime.february:
        return CalendarUtilits.isLeapYear(year) ? 29 : 28;
      case DateTime.march:
        return 31;
      case DateTime.april:
        return 30;
      case DateTime.may:
        return 31;
      case DateTime.june:
        return 30;
      case DateTime.july:
        return 31;
      case DateTime.august:
        return 31;
      case DateTime.september:
        return 30;
      case DateTime.october:
        return 31;
      case DateTime.november:
        return 30;
      case DateTime.december:
        return 31;
      default:
        return 0;
    }
  }

  static int nextMonth(int month) {
    int next = month + 1;
    return (next == DateTime.monthsPerYear + 1) ? 1 : next;
  }

  static int prevMonth(int month) {
    int prev = month - 1;
    return (prev == 0) ? DateTime.monthsPerYear : prev;
  }

  static int nextDay(int day, int month, int year) {
    int next = day + 1;
    return (next == getDayInMonth(month, year) + 1) ? 1 : next;
  }

  static int prevDay(int day, int month, int year) {
    int prev = day - 1;
    return (prev == 0) ? getDayInMonth(prevMonth(month), year) : prev;
  }
}

class CalendarUtilitsByContext {
  final BuildContext context;
  CalendarUtilitsByContext.of(this.context);

  String getNameMonth(int month) {
    switch (month) {
      case DateTime.january:
        return AppLocalizations.of(context)!.january;
      case DateTime.february:
        return AppLocalizations.of(context)!.february;
      case DateTime.march:
        return AppLocalizations.of(context)!.march;
      case DateTime.april:
        return AppLocalizations.of(context)!.april;
      case DateTime.may:
        return AppLocalizations.of(context)!.may;
      case DateTime.june:
        return AppLocalizations.of(context)!.june;
      case DateTime.july:
        return AppLocalizations.of(context)!.july;
      case DateTime.august:
        return AppLocalizations.of(context)!.august;
      case DateTime.september:
        return AppLocalizations.of(context)!.september;
      case DateTime.october:
        return AppLocalizations.of(context)!.october;
      case DateTime.november:
        return AppLocalizations.of(context)!.november;
      case DateTime.december:
        return AppLocalizations.of(context)!.december;
      default:
        return "";
    }
  }

  String getShortNameMonth(int month) {
    switch (month) {
      case DateTime.january:
        return AppLocalizations.of(context)!.januaryShort;
      case DateTime.february:
        return AppLocalizations.of(context)!.februaryShort;
      case DateTime.march:
        return AppLocalizations.of(context)!.marchShort;
      case DateTime.april:
        return AppLocalizations.of(context)!.aprilShort;
      case DateTime.may:
        return AppLocalizations.of(context)!.mayShort;
      case DateTime.june:
        return AppLocalizations.of(context)!.juneShort;
      case DateTime.july:
        return AppLocalizations.of(context)!.julyShort;
      case DateTime.august:
        return AppLocalizations.of(context)!.augustShort;
      case DateTime.september:
        return AppLocalizations.of(context)!.septemberShort;
      case DateTime.october:
        return AppLocalizations.of(context)!.octoberShort;
      case DateTime.november:
        return AppLocalizations.of(context)!.novemberShort;
      case DateTime.december:
        return AppLocalizations.of(context)!.decemberShort;
      default:
        return "";
    }
  }
}

Color? getColor(
    {bool isNow = false,
    bool isWeekend = false,
    Brightness brightness = Brightness.light}) {
  if (isNow) return Colors.green.shade500;
  if (isWeekend) {
    return (brightness == Brightness.light)
        ? Colors.blue.shade100
        : Colors.grey.shade700;
  }
  return null;
}

ShapeBorder? getShape({bool isTask = false}) {
  if (isTask) {
    return ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blue, width: 3));
  }
  return null;
}
