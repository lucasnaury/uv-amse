import 'package:flutter/material.dart';

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = duration.inMinutes.toString();
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

void showSnackbar(String text, var context, [Duration? duration]) {
  SnackBar snackBar = SnackBar(
      duration: duration ?? const Duration(seconds: 2), content: Text(text));

  // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
