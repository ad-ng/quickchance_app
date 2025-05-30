import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                onTap: () => context.pushNamed('dashUsersPage'),
                leading: Icon(Icons.people),
                title: Text('users'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.post_add_rounded),
                title: Text('opportunities'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              child: ListTile(
                onTap: () => context.pushNamed('dashCatPage'),
                leading: Icon(Icons.category_rounded),
                title: Text('categories'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.notification_add_rounded),
                title: Text('notifications'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
