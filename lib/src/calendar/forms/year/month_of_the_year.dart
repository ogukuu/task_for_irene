import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/forms/sub_period.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class MonthOfTheYear extends StatelessWidget {
  const MonthOfTheYear({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    bool isNow = currentMonth(date);
    bool active = (DateTime.now().isBefore(date) || isNow);
    double elevation = (active) ? 2 : 0;
    bool isTask = GlobalVar.appController.isTaskForThisMonth(date);
    return SubPeriod(
        onLongPress: () {
          Navigator.restorablePushNamed(
              context, NavRoute.addTaskWithDate + toURL(date));
        },
        onActive: active,
        width: maxWidth / 3,
        onTap: () => GlobalVar.appController.calendarController.down(date),
        child: Card(
            color: getColor(isNow: isNow),
            shape: getShape(isTask: isTask),
            elevation: elevation,
            child: Center(
                child: Text(
              CalendarUtilitsByContext.of(context).getNameMonth(date.month),
              overflow: TextOverflow.ellipsis,
            ))));

    // return GestureDetector(
    //   onTap: () => controller.updatePeriodType(controller.period.down(date)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(0.0),
    //     child: SizedBox(
    //         width: 50,
    //         height: 50,
    //         child: Card(
    //             child: Center(
    //           child: Text(
    //             CalendarUtilitsByContext.of(context).getNameMonth(date.month),
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ))),
    //   ),
    // );
  }
}
