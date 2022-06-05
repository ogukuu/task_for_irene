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
