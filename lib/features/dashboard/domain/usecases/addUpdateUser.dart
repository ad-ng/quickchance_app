import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/myTextField.dart';

void addUpdateUser(
  BuildContext context,
  String title,
  String nameOfAction,
  TextEditingController fullname,
  TextEditingController username,
  TextEditingController password,
  TextEditingController email,
  String? gender,
  String? role,
) {
  showDialog(
    context: context,
    builder: (context) {
      List<String> genderItems = ['Gender', 'male', 'female'];
      String genderDropDownValue = gender ?? 'Gender';

      List<String> roleItems = ['Role', 'admin', 'moderator', 'user'];
      String roleDropDownValue = role ?? 'Role';

      return AlertDialog(
        title: Text(title),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.46,
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Column(
                children: [
                  MyTextField(myController: fullname, labelText: 'full name'),
                  SizedBox(height: 8),
                  MyTextField(myController: username, labelText: 'username'),
                  SizedBox(height: 8),
                  MyTextField(myController: password, labelText: 'Password'),
                  SizedBox(height: 8),
                  MyTextField(myController: email, labelText: 'email'),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: genderDropDownValue,
                        dropdownColor: Colors.blue[300],
                        items:
                            genderItems.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderDropDownValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: roleDropDownValue,
                        dropdownColor: Colors.blue[300],
                        items:
                            roleItems.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            roleDropDownValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
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
      );
    },
  );
}
