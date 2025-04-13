import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Welcome Adolphe 👋'),
            ],
          ),
          Badge(
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
        ],
      ),
    );
  }
}
