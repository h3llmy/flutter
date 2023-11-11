import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String message) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  });
}
