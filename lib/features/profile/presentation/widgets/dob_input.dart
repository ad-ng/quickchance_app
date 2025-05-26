import 'package:flutter/material.dart';

class DobInput extends StatefulWidget {
  final TextEditingController dobController;

  const DobInput({super.key, required this.dobController});

  @override
  State<DobInput> createState() => _DobInputState();
}

class _DobInputState extends State<DobInput> {
  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      // Calculate the date 18 years ago from today
      DateTime today = DateTime.now();
      DateTime minDate = DateTime(today.year - 18, today.month, today.day);

      DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: minDate,
        initialDate: minDate, // Set initial date as the minimum date
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

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.44,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: widget.dobController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_month),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.black,
            filled: true,
            hintText: 'DATE',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          readOnly: true,
          onTap: () => selectDate(),
        ),
      ),
    );
  }
}
