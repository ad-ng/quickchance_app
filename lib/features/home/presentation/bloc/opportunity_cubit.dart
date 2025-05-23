import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/domain/repository/opps_repo.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  final OppsRepo oppsRepo;
  OpportunityCubit(this.oppsRepo) : super(OpportunityInitial()) {
    fetchAllOpps();
  }

  Future fetchAllOpps() async {
    emit(OpportunityLoading());
    try {
      final response = await oppsRepo.fetchAllOpps();
      emit(OpportunitySuccess(response));
    } catch (e) {
      emit(OpportunityError(e.toString()));
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

class OpportunityError extends OpportunityState {
  final String error;
  OpportunityError(this.error);
}
