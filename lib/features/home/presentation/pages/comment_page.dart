import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/bloc/commentCubit.dart';
import 'package:quickchance_app/features/home/presentation/widgets/commentCard.dart';
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
  void initState() {
    BlocProvider.of<CommentCubit>(context).fetchAllComments(widget.oppId, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 10),
          CommentTextField(
            commentController: commentController,
            oppId: widget.oppId,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state is CommentLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                if (state is CommentError) {
                  return Text(state.error);
                }
                if (state is CommentSuccess) {
                  return ListView.builder(
                    itemCount: state.response.length,
                    itemBuilder:
                        (context, index) =>
                            CommentCard(comment: state.response[index]),
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
