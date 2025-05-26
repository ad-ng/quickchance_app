import 'package:flutter/material.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';
import 'package:quickchance_app/features/profile/data/datasource/profileapiservice.dart';
import 'package:quickchance_app/features/profile/data/model/updateUserModel.dart';
import 'package:quickchance_app/features/profile/presentation/widgets/dob_input.dart';
import 'package:quickchance_app/features/profile/presentation/widgets/gender_picker.dart';

class EditProfile extends StatefulWidget {
  final UserModel currentUser;
  const EditProfile({super.key, required this.currentUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController(
      text: widget.currentUser.username,
    );
    TextEditingController fullname = TextEditingController(
      text: widget.currentUser.fullname,
    );
    TextEditingController location = TextEditingController(
      text: widget.currentUser.location,
    );
    TextEditingController phoneNumber = TextEditingController(
      text: widget.currentUser.phoneNumber,
    );
    TextEditingController dob = TextEditingController(
      text: widget.currentUser.dob,
    );
    TextEditingController gender = TextEditingController(
      text: widget.currentUser.gender,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Username:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            MyInput(
              hintText: 'username',
              suffixIcon: Icon(Icons.person),
              isPassword: false,
              textEditingController: username,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Full Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            MyInput(
              hintText: 'Full name',
              suffixIcon: Icon(Icons.person),
              isPassword: false,
              textEditingController: fullname,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            MyInput(
              hintText: 'location',
              suffixIcon: Icon(Icons.location_on_rounded),
              isPassword: false,
              textEditingController: location,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Phone Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            MyInput(
              hintText: 'Phone number',
              suffixIcon: Icon(Icons.phone_outlined),
              isPassword: false,
              textEditingController: phoneNumber,
            ),

            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Date Of Birth:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DobInput(dobController: dob),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GenderPicker(genderController: gender),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                if (isLoading) {
                  if (username.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                            'New Password mismatches with Confirm Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    await ProfileApiService().updateUser(
                      UpdateUserModel(
                        dob: dob.text,
                        fullname: fullname.text,
                        gender: gender.text,
                        location: location.text,
                        phoneNumber: phoneNumber.text,
                        username: username.text,
                      ),
                      context,
                    );
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child:
                      (isLoading)
                          ? CircularProgressIndicator.adaptive()
                          : Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
