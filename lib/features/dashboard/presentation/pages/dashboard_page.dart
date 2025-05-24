import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('100 users'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('20 users'),
                    Text('8 moderators'),
                    Text('2 admins'),
                  ],
                ),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.post_add_rounded),
                title: Text('100 posts'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.category_rounded),
                title: Text('9 categories'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
