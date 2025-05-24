import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
      ),
      title: Text('user 1'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'hdhhdgdg dhdhhdhd dhdhhdhhdhhd hdhdhhhd hdhhdhhdhd hdhdhhdhhd dhdhhdhhd',
          ),
          Text('2 hours ago', style: TextStyle(color: Colors.grey)),
        ],
      ),
      isThreeLine: true,
      trailing: Icon(Icons.more_vert_rounded),
    );
  }
}
