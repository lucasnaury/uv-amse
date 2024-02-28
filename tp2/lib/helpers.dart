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

// Floating btn widget
class MyFloatingButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final Color? color;
  final bool disabled;

  const MyFloatingButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.color,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(10),
      child: IconButton(
        icon: Icon(icon),
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: disabled
              ? MaterialStateProperty.all<Color>(Colors.grey)
              : MaterialStateProperty.all<Color>(
                  color ?? Theme.of(context).colorScheme.primary),
          iconColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
