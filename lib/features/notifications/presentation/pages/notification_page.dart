import 'package:flutter/material.dart';
import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationApiService.dart';
import 'package:quickchance_app/features/notifications/presentation/widgets/notificationCard.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: NotificationApiService().fetchAllUserNotification(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder:
                        (context, index) => Notificationcard(
                          userNotification: snapshot.data![index],
                          key: ValueKey(snapshot.data![index].id),
                        ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
