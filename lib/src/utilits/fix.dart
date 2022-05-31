import 'package:flutter/material.dart';

MaterialStateProperty<Color?>? elevatedButtonBackgroundFix(
    BuildContext context) {
  return (Theme.of(context).brightness == Brightness.dark)
      ? MaterialStateProperty.all(
          Theme.of(context).buttonTheme.colorScheme?.background)
      : ElevatedButtonTheme.of(context).style?.backgroundColor;
}
