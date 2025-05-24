import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  final TextEditingController commentController;
  const CommentTextField({super.key, required this.commentController});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: widget.commentController,
          maxLines: 4,
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
              onPressed: () {},
              icon: Icon(Icons.send_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
