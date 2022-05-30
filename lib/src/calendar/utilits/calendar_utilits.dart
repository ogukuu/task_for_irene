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
}
