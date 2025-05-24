import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';
import 'package:timeago/timeago.dart' as timeago;

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
              Text(
                timeago.format(DateTime.parse(comment.createdAt!)),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          isThreeLine: true,
          trailing: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  showPopover(
                    context: context,
                    direction: PopoverDirection.left,
                    bodyBuilder:
                        (context) => Container(
                          width: 120,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Report',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.flag, color: Colors.black),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.delete, color: Colors.black),
                                ],
                              ),
                            ],
                          ),
                        ),
                  );
                },
                child: Icon(Icons.more_vert_rounded),
              );
            },
          ),
        ),
      ),
    );
  }
}
