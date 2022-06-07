import 'package:flutter/material.dart';

class SubPeriod extends StatelessWidget {
  const SubPeriod(
      {Key? key,
      required this.child,
      this.onActive = true,
      this.onTap,
      this.onLongPress,
      this.width = double.infinity,
      this.height})
      : super(key: key);

  final Widget child;
  final bool onActive;
  final Function()? onTap;
  final Function()? onLongPress;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    fyncOnTap() {
      if (onActive && !(onTap == null)) onTap!();
    }

    fyncOnLongPress() {
      if (onActive && !(onLongPress == null)) onLongPress!();
    }

    return GestureDetector(
      onLongPress: fyncOnLongPress,
      onTap: fyncOnTap,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
