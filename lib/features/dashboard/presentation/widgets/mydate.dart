import 'package:flutter/material.dart';

class MyDate extends StatefulWidget {
  final TextEditingController dobController;

  const MyDate({super.key, required this.dobController});

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {
  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              // accentColor: Colors.blue,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          widget.dobController.text = '${picked.toIso8601String()}Z';
        });
      }
    }

    return TextFormField(
      controller: widget.dobController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        hintText: 'deadline',
      ),
      readOnly: true,
      onTap: () => selectDate(),
    );
  }
}
