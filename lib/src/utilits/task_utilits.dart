import 'package:flutter/material.dart';

import '../models/task.dart';

Widget getStatusImage(Task task) {
  switch (task.status) {
    case StatusTask.fail:
      return Image.asset('assets/images/fail.png');
    case StatusTask.surrendered:
      return Image.asset('assets/images/surrendered.png');
    case StatusTask.completed:
      return task.photoProof ??
          Image.asset('assets/images/error_not_found_proof.png');
    default:
      return Image.asset('assets/images/error.png');
  }
}
