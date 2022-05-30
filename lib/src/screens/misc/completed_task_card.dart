import 'package:flutter/material.dart';

import '../../models/task.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard(this._task, {Key? key}) : super(key: key);
  final Task _task;

  Widget _proofPhoto(double maxSize) {
    const double defSize = 150;
    final double currentSize = defSize > maxSize ? maxSize : defSize;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: currentSize,
            height: currentSize,
            child: FittedBox(fit: BoxFit.cover, child: _getStatusImage())));
  }

  Widget _getStatusImage() {
    switch (_task.status) {
      case StatusTask.fail:
        return Image.asset('assets/images/fail.jpg');
      case StatusTask.surrender:
        return Image.asset('assets/images/surrender.jpg');
      case StatusTask.completed:
        return _task.photoProof ?? Image.asset('assets/images/error.jpg');
      default:
        return Image.asset('assets/images/error.jpg');
    }
  }

  Widget _taskInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_task.title,
            overflow: TextOverflow.ellipsis,
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3)),
        const Divider(height: 16, indent: 10, endIndent: 10),
        Text(_task.description)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidthProofPhoto = MediaQuery.of(context).size.width / 3;
    return Card(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: [
          _proofPhoto(maxWidthProofPhoto),
          Expanded(child: _taskInfo(context))
        ]));
  }
}
