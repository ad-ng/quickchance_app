import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunityApiService.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';

class CommentTextField extends StatefulWidget {
  final TextEditingController commentController;
  final int oppId;
  const CommentTextField({
    super.key,
    required this.commentController,
    required this.oppId,
  });

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: widget.commentController,
          maxLines: 3,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'write your comment here.....',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: IconButton(
              onPressed: () async {
                OpportunityApiService().postComment(
                  CommentModel(
                    oppId: widget.oppId,
                    body: widget.commentController.text,
                  ),
                );
                widget.commentController.clear();
              },
              icon: Icon(Icons.send_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
