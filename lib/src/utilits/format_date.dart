import 'package:flutter/material.dart';

String getDDMMYYYY(DateTime dateTime) {
  int d = dateTime.day;
  int m = dateTime.month;
  int y = dateTime.year;
  String dd = (d < 10) ? "0$d" : "$d";
  String mm = (m < 10) ? "0$m" : "$m";
  String yyyy = (y < 10)
      ? "000$y"
      : (y < 100)
          ? "00$y"
          : (y < 1000)
              ? "0$y"
              : "$y";
  return "$dd-$mm-$yyyy";
}

String getHHMMTimeOfDay(TimeOfDay timeOfDay) {
  int h = timeOfDay.hour;
  int m = timeOfDay.minute;
  String hh = (h < 10) ? "0$h" : "$h";
  String mm = (m < 10) ? "0$m" : "$m";
  return "$hh:$mm";
}

String getHHMMDateTime(DateTime dateTime) {
  int h = dateTime.hour;
  int m = dateTime.minute;
  String hh = (h < 10) ? "0$h" : "$h";
  String mm = (m < 10) ? "0$m" : "$m";
  return "$hh:$mm";
}

bool sameYear(DateTime d1, DateTime d2) => d1.year == d2.year;
bool sameMonth(DateTime d1, DateTime d2) =>
    sameYear(d1, d2) && (d1.month == d2.month);
bool sameDay(DateTime d1, DateTime d2) =>
    sameMonth(d1, d2) && (d1.day == d2.day);
bool sameHour(DateTime d1, DateTime d2) =>
    sameDay(d1, d2) && (d1.hour == d2.hour);

bool currentYear(DateTime dateTime) => sameYear(dateTime, DateTime.now());
bool currentMonth(DateTime dateTime) => sameMonth(dateTime, DateTime.now());
bool currentDay(DateTime dateTime) => sameDay(dateTime, DateTime.now());
bool currentHour(DateTime dateTime) => sameHour(dateTime, DateTime.now());

String toURL(DateTime dateTime) {
  int D = dateTime.day;
  int M = dateTime.month;
  int Y = dateTime.year;
  // ignore: non_constant_identifier_names
  String DD = (D < 10) ? "0$D" : "$D";
  // ignore: non_constant_identifier_names
  String MM = (M < 10) ? "0$M" : "$M";
  // ignore: non_constant_identifier_names
  String YYYY = (Y < 10)
      ? "000$Y"
      : (Y < 100)
          ? "00$Y"
          : (Y < 1000)
              ? "0$Y"
              : "$Y";
  int h = dateTime.hour;
  int m = dateTime.minute;
  String hh = (h < 10) ? "0$h" : "$h";
  String mm = (m < 10) ? "0$m" : "$m";
  return "Y=$YYYY,M=$MM,D=$DD,h=$hh,m=$mm";
}

DateTime toDatetime(String url) {
  DateTime error = DateTime(0);
  if (!url.startsWith("Y=") ||
      !url.startsWith(",M=", 6) ||
      !url.startsWith(",D=", 11) ||
      !url.startsWith(",h=", 16) ||
      !url.startsWith(",m=", 21)) return error;
  // ignore: non_constant_identifier_names
  int YYYY = int.parse(url.substring(2, 6));
  // ignore: non_constant_identifier_names
  int MM = int.parse(url.substring(9, 11));
  // ignore: non_constant_identifier_names
  int DD = int.parse(url.substring(14, 16));
  int hh = int.parse(url.substring(19, 21));
  int mm = int.parse(url.substring(24, 26));
  return DateTime(YYYY, MM, DD, hh, mm);
}
