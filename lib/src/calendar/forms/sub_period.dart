import 'package:flutter/material.dart';

class SubPeriod extends StatelessWidget {
  const SubPeriod(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isPast,
      required this.containsTask})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final bool isPast;
  final bool containsTask;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (!isPast) onTap;
      }),
      child: _Card(
        isPast: isPast,
        title: title,
        containsTask: containsTask,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.isPast,
    required this.title,
    required this.containsTask,
  }) : super(key: key);

  final bool isPast;
  final String title;
  final bool containsTask;

  @override
  Widget build(BuildContext context) {
    if (containsTask) {
      return Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.green,
          ),
        ),
        elevation: (isPast) ? 0 : 2,
        child: _Body(title: title),
      );
    } else {
      return Card(
        elevation: (isPast) ? 0 : 2,
        child: _Body(title: title),
      );
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title,
      overflow: TextOverflow.ellipsis,
    ));
  }
}
