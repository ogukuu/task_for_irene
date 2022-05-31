import 'package:flutter/material.dart';

String formatDate(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

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
