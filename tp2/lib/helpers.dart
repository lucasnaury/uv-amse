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

void showCustomDialog(
  BuildContext context, {
  required String title,
  required String leftBtnText,
  required Function() leftBtnPressed,
  required String rightBtnText,
  required Function() rightBtnPressed,
}) {
  showDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return Center(
        child: Container(
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(leftBtnText),
                    onPressed: () {
                      leftBtnPressed();

                      //Close dialog
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    child: Text(rightBtnText),
                    onPressed: () {
                      rightBtnPressed();

                      //Close dialog
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
