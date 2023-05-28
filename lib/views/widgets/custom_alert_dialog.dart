import 'package:flutter/material.dart';

void customAlertDialog(BuildContext context,
    {required String label,
    required VoidCallback onPressedYesOption,
    String yesOptionLabel = 'Yes'}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(label),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  onPressedYesOption();

                  ///on pop in from alert
                  Navigator.of(context).pop();
                },
                child: Text(yesOptionLabel)),
          ],
        );
      });
}
