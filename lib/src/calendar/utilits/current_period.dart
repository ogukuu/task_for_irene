import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';

class CurrentPeriod {
  late final List<DateTime> _dates;
  get dates => _dates;

  List<DateTime> getExtendedMonthDates(int firstDayOfTheWeek) {
    if (periodType == PeriodType.day ||
        periodType == PeriodType.year ||
        firstDayOfTheWeek > 7 ||
        firstDayOfTheWeek < 1) {
      return [];
    }
    List<DateTime> tempDates = List.from(_dates, growable: true);
    DateTime tempDay;
    tempDay = _dates.first;
    while (tempDay.weekday != firstDayOfTheWeek) {
      tempDay.subtract(const Duration(days: 1));
      tempDates.insert(0, tempDay);
    }
    tempDay = _dates.last;
    int lastDayOfTheWeek = ((firstDayOfTheWeek - 1) % DateTime.daysPerWeek == 0)
        ? DateTime.daysPerWeek
        : (firstDayOfTheWeek - 1);
    while (tempDay.weekday != lastDayOfTheWeek) {
      tempDay.add(const Duration(days: 1));
      tempDates.add(tempDay);
    }
    return tempDates;
  }

  final PeriodType periodType;

  CurrentPeriod.now(this.periodType) {
    var now = DateTime.now();
    switch (periodType) {
      case PeriodType.day:
        {
          _dates = List.generate(
              24, (index) => DateTime(now.year, now.month, now.day, index),
              growable: false);
          break;
        }
      case PeriodType.month:
        {
          _dates = List.generate(
              CalendarUtilits.getDayInMonth(now.month, now.year),
              (index) => DateTime(now.year, now.month, index + 1),
              growable: false);
          break;
        }
      case PeriodType.year:
        {
          _dates = List.generate(
              DateTime.monthsPerYear, (index) => DateTime(now.year, index + 1),
              growable: false);
          break;
        }
    }
  }

  CurrentPeriod.forDate(DateTime date, this.periodType) {
    switch (periodType) {
      case PeriodType.day:
        {
          _dates = List.generate(
              24, (index) => DateTime(date.year, date.month, date.day, index),
              growable: false);
          break;
        }
      case PeriodType.month:
        {
          _dates = List.generate(
              CalendarUtilits.getDayInMonth(date.month, date.year),
              (index) => DateTime(date.year, date.month, index + 1),
              growable: false);
          break;
        }
      case PeriodType.year:
        {
          _dates = List.generate(
              DateTime.monthsPerYear, (index) => DateTime(date.year, index + 1),
              growable: false);
          break;
        }
    }
  }
}

enum PeriodType { year, month, day }

enum FirstDayOfTheWeek {
  sunday(DateTime.sunday),
  monday(DateTime.monday);

  // ignore: unused_field
  final int _day;
  const FirstDayOfTheWeek(this._day);
}
