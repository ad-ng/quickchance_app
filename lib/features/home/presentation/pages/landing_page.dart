import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/home/presentation/pages/homePage.dart';
import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationSocketService.dart';
import 'package:quickchance_app/features/profile/presentation/pages/profilePage.dart';
import 'package:quickchance_app/features/saved/presentation/pages/savedPage.dart';
import 'package:quickchance_app/features/search/presentation/pages/searchPage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

const pages = [Homepage(), SearchPage(), SavedPage(), ProfilePage()];

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  int _notificationCount = 0;
  final notificationSocketService = NotificationSocketService();

  @override
  void initState() {
    super.initState();
    notificationSocketService.joinNotification();
    notificationSocketService.getNotificationCount();

    // Listen to notification
    notificationSocketService.socket.on('countNotificationReply', (data) {
      setState(() {
        _notificationCount = data['notificationCount'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Chance'),
        actions: [
          Badge(
            label: Text(
              (_notificationCount < 9) ? '${_notificationCount}' : '9+',
              style: TextStyle(fontSize: 12),
            ),
            child: IconButton(
              onPressed: () => context.push('/notificationPage'),
              icon: Icon(Icons.notifications_none, size: 30),
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_rounded),
            label: 'saved',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
    );
  }
}
