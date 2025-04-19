import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Column(
        children: [
          ListTile(
            onTap: () => context.pushNamed('changePassword'),
            leading: Icon(Icons.lock),
            title: Text(
              'Change Password',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            leading: Icon(Icons.notifications_none_rounded),
            title: Text('Notification', style: TextStyle(color: Colors.grey)),
            trailing: Switch(
              value: isNotification,
              onChanged: (value) {
                setState(() {
                  isNotification = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text(
              'Terms & Policies',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            leading: Icon(Icons.question_mark_outlined),
            title: Text('Help & Support', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            leading: Icon(Icons.delete_sharp),
            title: Text('Delete Account', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.clear();
              context.goNamed('login');
            },
            leading: Icon(Icons.logout_rounded, color: Colors.red[300]),
            title: Text('Log Out', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
