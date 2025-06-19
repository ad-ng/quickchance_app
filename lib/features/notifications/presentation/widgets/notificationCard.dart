import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/notifications/data/models/userNotification.dart';

class Notificationcard extends StatelessWidget {
  final UserNotification userNotification;
  const Notificationcard({super.key, required this.userNotification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
      child: Card(
        child: ListTile(
          onTap: () {
            if (userNotification.notification.opportunityId != null) {
              context.pushNamed(
                'OppPage',
                extra: userNotification.notification.opportunity,
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(userNotification.notification.title),
                    content: Text(userNotification.notification.body),
                    actions: [
                      TextButton(
                        onPressed: () {
                          
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          title: Text(userNotification.notification.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userNotification.notification.body,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userNotification.createdAt.substring(0, 10)),
                  Text(userNotification.createdAt.substring(11, 16)),
                ],
              ),
            ],
          ),
          trailing: Icon(Icons.more_vert_outlined),
        ),
      ),
    );
  }
}
