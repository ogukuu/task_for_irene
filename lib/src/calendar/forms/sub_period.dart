import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';

class SubPeriod extends StatelessWidget {
  const SubPeriod(
      {Key? key,
      required this.child,
      this.onActive = true,
      this.onTap,
      this.onLongPress,
      this.width = double.infinity})
      : super(key: key);

  final Widget child;
  final bool onActive;
  final Function()? onTap;
  final Function()? onLongPress;
  final double width;

  @override
  Widget build(BuildContext context) {
    fyncOnTap() {
      if (onActive && !(onTap == null)) onTap!();
    }

    fyncOnLongPress() {
      if (onActive && !(onLongPress == null)) onLongPress!();
    }

    double height = width / GlobalVar.goldenRatio;
    return GestureDetector(
      onLongPress: fyncOnLongPress,
      onTap: fyncOnTap,
      child: SizedBox(
        width: width,
        height: (width == double.infinity) ? null : height,
        child: child,
      ),
    );
  }
}
