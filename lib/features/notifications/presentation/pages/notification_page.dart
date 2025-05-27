import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/notifications/presentation/bloc/eachNotificationCubit.dart';
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
            child: BlocBuilder<EachNotificationCubit, EachNotificationState>(
              builder: (context, state) {
                if (state is EachNotificationError) {
                  return Center(child: Text(state.error));
                }

                if (state is EachNotificationSuccess) {
                  return ListView.builder(
                    itemCount: state.response.length,
                    itemBuilder:
                        (context, index) => Notificationcard(
                          userNotification: state.response[index],
                        ),
                  );
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
