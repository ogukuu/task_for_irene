import 'package:flutter/material.dart';
import 'package:task_for_irene/src/task/task.dart';

Widget getStatusImage({required String status, dynamic photoProof}) {
  switch (status) {
    case StatusTask.fail:
      return Image.asset('assets/images/fail.png');
    case StatusTask.surrendered:
      return Image.asset('assets/images/surrendered.png');
    case StatusTask.success:
      if (photoProof == null) {
        return Image.asset('assets/images/error_not_found_proof.png');
      } else {
        return Image.memory(photoProof);
      }

    default:
      return Image.asset('assets/images/error.png');
  }
}
