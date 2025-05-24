import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
      ),
      title: Text(comment.user!.fullname!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.body),
          Text('2 hours ago', style: TextStyle(color: Colors.grey)),
        ],
      ),
      isThreeLine: true,
      trailing: Icon(Icons.more_vert_rounded),
    );
  }
}
