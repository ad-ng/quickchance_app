import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/search/domain/repository/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitial());

  Future searchOpp(String searchQuery) async {
    emit(SearchLoading());
    try {
      final response = await searchRepo.searchOpp(searchQuery);
      emit(SearchSuccess(response));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<OpportunityModel> response;
  SearchSuccess(this.response);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
