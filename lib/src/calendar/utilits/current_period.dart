import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';

class CurrentPeriod {
  late final List<DateTime> _dates;
  List<DateTime> get dates => _dates;
  final PeriodType periodType;

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
      tempDay = tempDay.subtract(const Duration(days: 1));
      tempDates.insert(0, tempDay);
    }
    tempDay = _dates.last;
    int lastDayOfTheWeek = ((firstDayOfTheWeek - 1) % DateTime.daysPerWeek == 0)
        ? DateTime.daysPerWeek
        : (firstDayOfTheWeek - 1);
    while (tempDay.weekday != lastDayOfTheWeek) {
      tempDay = tempDay.add(const Duration(days: 1));
      tempDates.add(tempDay);
    }
    return tempDates;
  }

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

  bool equals(CurrentPeriod other) {
    return (periodType == other.periodType) &&
        (_dates.first.isAtSameMomentAs(other.dates.first));
  }

  CurrentPeriod up() {
    switch (periodType) {
      case PeriodType.month:
        return CurrentPeriod.forDate(_dates.first, PeriodType.year);
      case PeriodType.day:
        return CurrentPeriod.forDate(_dates.first, PeriodType.month);
      case PeriodType.year:
      default:
        return this;
    }
  }

  CurrentPeriod down(DateTime pick) {
    switch (periodType) {
      case PeriodType.month:
        return CurrentPeriod.forDate(pick, PeriodType.day);
      case PeriodType.year:
        return CurrentPeriod.forDate(pick, PeriodType.month);
      case PeriodType.day:
      default:
        return this;
    }
  }

  CurrentPeriod next() {
    DateTime newDate;
    switch (periodType) {
      case PeriodType.month:
        newDate = _dates.first.add(const Duration(days: 32));
        break;
      case PeriodType.year:
        newDate = _dates.first.add(const Duration(days: 366));
        break;
      case PeriodType.day:
      default:
        newDate = _dates.first.add(const Duration(days: 1));
    }
    return CurrentPeriod.forDate(newDate, periodType);
  }

  CurrentPeriod prev() {
    return CurrentPeriod.forDate(
        _dates.first.subtract(const Duration(days: 1)), periodType);
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
