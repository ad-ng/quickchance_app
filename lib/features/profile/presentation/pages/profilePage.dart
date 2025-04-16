import 'package:flutter/material.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Text(
              'My Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
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
                          'https://static1.cbrimages.com/wordpress/wp-content/uploads/2024/12/15-best-character-arcs-in-avatar-the-last-airbender-ranked.jpg',
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
                          Container(
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
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Row(children: [Column(children: [])]),
        ],
      ),
    );
  }
}
