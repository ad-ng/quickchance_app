import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/domain/repository/opps_repo.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  final OppsRepo oppsRepo;
  OpportunityCubit(this.oppsRepo) : super(OpportunityInitial());

  Future fetchAllOpps() async {
    emit(OpportunityLoading());
    try {
      final response = await oppsRepo.fetchAllOpps();
      emit(OpportunitySuccess(response));
    } catch (e) {
      emit(OpportunityError(e.toString()));
    }
  }

  Future checkIfLiked(int oppId) async {
    bool checkLiked = await oppsRepo.checkLikes(oppId);

    try {
      checkLiked ? oppsRepo.unLikingOpp(oppId) : oppsRepo.likingOpp(oppId);
      emit(OpportunityLikesSuccess(checkLiked));
    } catch (e) {
      emit(OpportunityLikesError(e.toString()));
    }
  }

  Future totalLikes(int oppId) async {
    try {
      final response = await oppsRepo.totalLikes(oppId);
      emit(OpportunityTotalLikesSuccess(response));
    } catch (e) {
      emit(OpportunityTotalLikesError(e.toString()));
    }
  }
}

abstract class OpportunityState {}

class OpportunityInitial extends OpportunityState {}

class OpportunityLoading extends OpportunityState {}

class OpportunitySuccess extends OpportunityState {
  final List<OpportunityModel> response;
  OpportunitySuccess(this.response);
}

class OpportunityLikesSuccess extends OpportunityState {
  final bool response;
  OpportunityLikesSuccess(this.response);
}

class OpportunityTotalLikesSuccess extends OpportunityState {
  final int response;
  OpportunityTotalLikesSuccess(this.response);
}

class OpportunityError extends OpportunityState {
  final String error;
  OpportunityError(this.error);
}

class OpportunityLikesError extends OpportunityState {
  final String error;
  OpportunityLikesError(this.error);
}

class OpportunityTotalLikesError extends OpportunityState {
  final String error;
  OpportunityTotalLikesError(this.error);
}
