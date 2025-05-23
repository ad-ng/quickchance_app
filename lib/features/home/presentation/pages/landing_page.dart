import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/home/presentation/pages/homePage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Chance'),
        actions: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => context.push('/notificationPage'),
                child: Badge(
                  label: Text('10'),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.notifications_none, size: 30),
                  ),
                ),
              );
            },
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
