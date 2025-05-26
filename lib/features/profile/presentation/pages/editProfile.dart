import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';
import 'package:quickchance_app/features/profile/data/datasource/profileapiservice.dart';
import 'package:quickchance_app/features/profile/data/model/updateUserModel.dart';
import 'package:quickchance_app/features/profile/presentation/bloc/profilecubit.dart';
import 'package:quickchance_app/features/profile/presentation/widgets/dob_input.dart';
import 'package:quickchance_app/features/profile/presentation/widgets/gender_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getLocalUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController fullname = TextEditingController();
    TextEditingController location = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController dob = TextEditingController();
    TextEditingController gender = TextEditingController();

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
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  username.text = state.response.username!;
                  return MyInput(
                    hintText: 'username',
                    suffixIcon: Icon(Icons.person),
                    isPassword: false,
                    textEditingController: username,
                  );
                }
                return SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Full Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  fullname.text = state.response.fullname!;
                  return MyInput(
                    hintText: 'Full name',
                    suffixIcon: Icon(Icons.person),
                    isPassword: false,
                    textEditingController: fullname,
                  );
                }
                return SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  location.text = state.response.location!;
                  return MyInput(
                    hintText: 'location',
                    suffixIcon: Icon(Icons.location_on_rounded),
                    isPassword: false,
                    textEditingController: location,
                  );
                }
                return SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Phone Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  phoneNumber.text = state.response.phoneNumber!;
                  return MyInput(
                    hintText: 'Phone number',
                    suffixIcon: Icon(Icons.phone),
                    isPassword: false,
                    textEditingController: phoneNumber,
                  );
                }
                return SizedBox.shrink();
              },
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
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileSuccess) {
                          dob.text = state.response.dob!;
                          return DobInput(dobController: dob);
                        }
                        return SizedBox.shrink();
                      },
                    ),
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
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileSuccess) {
                          gender.text = state.response.gender!;
                          return GenderPicker(genderController: gender);
                        }
                        return SizedBox.shrink();
                      },
                    ),
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
                    setState(() {
                      isLoading = false;
                    });
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
