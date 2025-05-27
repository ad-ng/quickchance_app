import 'package:flutter/material.dart';
import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationApiService.dart';

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
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 4,
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data![index].notification.title,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].notification.body,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data![index].createdAt
                                            .substring(0, 10),
                                      ),
                                      Text(
                                        snapshot.data![index].createdAt
                                            .substring(11, 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.more_vert_outlined),
                            ),
                          ),
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
