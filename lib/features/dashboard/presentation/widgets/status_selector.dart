import 'package:flutter/material.dart';

class StatusSelector extends StatefulWidget {
  final TextEditingController statusController;
  const StatusSelector({super.key, required this.statusController});

  @override
  State<StatusSelector> createState() => _StatusSelectorState();
}

String dropDownValue = 'Status';

class _StatusSelectorState extends State<StatusSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: DropdownButton<String>(
            value: dropDownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
                widget.statusController.text = newValue;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: 'Status',
                child: Text('Status        '),
              ),
              DropdownMenuItem<String>(value: 'open', child: Text('open')),
              DropdownMenuItem<String>(value: 'closed', child: Text('closed')),
            ],
          ),
        ),
      ),
    );
  }
}
