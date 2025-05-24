import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
      child: Card(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              comment.user!.profileImg!,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(comment.user!.fullname!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.body),
              // Text(comment.createdAt!, style: TextStyle(color: Colors.grey)),
            ],
          ),
          isThreeLine: true,
          trailing: Icon(Icons.more_vert_rounded),
        ),
      ),
    );
  }
}
