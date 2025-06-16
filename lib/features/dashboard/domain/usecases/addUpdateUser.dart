import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/data/models/addUserModel.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/myTextField.dart';

void addUpdateUser(
  BuildContext context,
  String title,
  String nameOfAction,
  TextEditingController fullname,
  TextEditingController username,
  TextEditingController email,
  String? gender,
  String? role,
  int? userId,
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
          height: MediaQuery.of(context).size.height * 0.38,
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextField(myController: fullname, labelText: 'full name'),
                    SizedBox(height: 8),
                    MyTextField(myController: username, labelText: 'username'),
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
                              gender = newValue;
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
                              role = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
              (nameOfAction == 'Register')
                  ? DashboardApiService().addUser(
                    AddUserModel(
                      username: username.text,
                      fullname: fullname.text,
                      email: email.text,
                      gender: gender!,
                      role: role!,
                    ),
                  )
                  : DashboardApiService().updateUser(
                    AddUserModel(
                      username: username.text,
                      fullname: fullname.text,
                      email: email.text,
                      gender: gender!,
                      role: role!,
                    ),
                    userId!,
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
