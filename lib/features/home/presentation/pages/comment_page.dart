import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/presentation/widgets/commentTextField.dart';

class CommentPage extends StatefulWidget {
  final int oppId;
  const CommentPage({super.key, required this.oppId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 10),
          CommentTextField(commentController: commentController),
        ],
      ),
    );
  }
}
