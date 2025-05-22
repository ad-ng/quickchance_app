import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/core/theme_cubit.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  bool isNotification = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: UserPreferences().getLocalUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          snapshot.data!.profileImg!,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data!.fullname!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '@${snapshot.data!.username}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => context.pushNamed('editProfile'),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text('Dark Mode', style: TextStyle(color: Colors.grey)),
            trailing: Switch.adaptive(
              value: isDarkMode,
              onChanged: (value) {
                BlocProvider.of<ThemeCubit>(context).toggleTheme();
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
          ListTile(
            onTap: () => context.pushNamed('settingsPage'),
            leading: Icon(Icons.settings),
            title: Text('Setting', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          FutureBuilder(
            future: UserPreferences().getLocalUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('Location'),
                          trailing: Text('Kigali - Rwanda'),
                        ),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text('Email'),
                          trailing: Text(snapshot.data!.email!),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Phone Number'),
                          trailing: Text(snapshot.data!.phoneNumber!),
                        ),
                        ListTile(
                          leading: Icon(Icons.man_outlined),
                          title: Text('Gender'),
                          trailing: Text(snapshot.data!.gender!),
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Role'),
                          trailing: Text(snapshot.data!.role!),
                        ),
                        ListTile(
                          leading: Icon(Icons.baby_changing_station),
                          title: Text('Born'),
                          trailing: Text(snapshot.data!.dob!.substring(0, 10)),
                        ),
                        ListTile(
                          leading: Icon(Icons.verified_rounded),
                          title: Text('verification'),
                          trailing:
                              (snapshot.data!.isVerified)
                                  ? Text('Completed')
                                  : Text('Not completed'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
