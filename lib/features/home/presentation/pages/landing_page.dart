import 'package:flutter/material.dart';
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
