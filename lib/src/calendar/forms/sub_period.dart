import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';

class SubPeriod extends StatelessWidget {
  const SubPeriod(
      {Key? key,
      required this.child,
      this.onActive = true,
      this.onTap,
      this.width = double.infinity})
      : super(key: key);

  final Widget child;
  final bool onActive;
  final Function()? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    fyncOnTap() {
      if (onActive && !(onTap == null)) onTap!();
    }

    double height = width / GlobalVar.goldenRatio;
    return GestureDetector(
      onTap: fyncOnTap,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
