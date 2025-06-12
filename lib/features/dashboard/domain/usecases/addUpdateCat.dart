import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';

void addOrUpdateCategory(
  BuildContext context,
  TextEditingController categoryNameController,
  String nameOfAction,
  String title,
  int? catId,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Container(
          height: 40,
          width: 140,
          child: TextField(controller: categoryNameController),
        ),
        actions: [
          TextButton(
            onPressed: () {
              categoryNameController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              (nameOfAction == 'Update')
                  ? DashboardApiService().updateCategory(
                    categoryNameController.text,
                    catId!,
                  )
                  : DashboardApiService().addCategory(
                    categoryNameController.text,
                  );
              Navigator.pop(context);
            },
            child: Text(nameOfAction),
          ),
        ],
      );
    },
  );
}
