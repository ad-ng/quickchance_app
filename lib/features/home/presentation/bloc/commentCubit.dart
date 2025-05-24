import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';
import 'package:quickchance_app/features/home/domain/repository/opps_repo.dart';

class CommentCubit extends Cubit<CommentState> {
  final OppsRepo oppsRepo;
  CommentCubit(this.oppsRepo) : super(CommentInitial());

  Future fetchAllComments(int oppId, BuildContext context) async {
    emit(CommentLoading());
    try {
      final response = await oppsRepo.fetchAllComments(oppId, context);
      emit(CommentSuccess(response));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }
}

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentModel> response;
  CommentSuccess(this.response);
}

class CommentError extends CommentState {
  final String error;
  CommentError(this.error);
}
