import 'package:flutter/material.dart';

void showAlert(
    {required BuildContext context,
    required String message,
    required void Function() onPressed}) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  });
}
