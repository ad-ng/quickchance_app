import 'package:flutter/material.dart';

void addUpdateUser(BuildContext context, String title, String nameOfAction) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(nameOfAction),
            ),
          ],
        ),
  );
}
