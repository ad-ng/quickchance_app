import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
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
    BlocProvider.of<OpportunityCubit>(context).fetchAllComments(widget.oppId);
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
          Expanded(
            child: BlocBuilder<OpportunityCubit, OpportunityState>(
              builder: (context, state) {
                if (state is OpportunityCommentLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                if (state is OpportunityCommentError) {
                  return Text(state.error);
                }
                if (state is OpportunityCommentSuccess) {
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
