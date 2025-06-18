import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/profile/data/model/preference_model.dart';
import 'package:quickchance_app/features/profile/domain/repository/profile_repo.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';
import 'package:quickchance_app/features/search/data/models/categoryModel.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final ProfileRepo profileRepo;
  PreferencesCubit(this.profileRepo) : super(InitialPreference()) {
    getPreferences();
  }

  Future getPreferences() async {
    emit(PreferencesLoading());
    try {
      final preferences =
          await profileRepo.fetchPreferences(); // already selected
      final allCategories =
          await SearchApiService().fetchAllCategories(); // all available

      // Extract selected category IDs from preferences
      final selectedCategoryIds = preferences.map((e) => e.categoryId).toSet();

      // Filter out categories already in preferences
      final unselectedCategories =
          allCategories
              .where((category) => !selectedCategoryIds.contains(category.id))
              .toList();

      emit(PreferencesSuccess(preferences, unselectedCategories));
    } catch (e) {
      emit(PreferencesError(e.toString()));
    }
  }
}

abstract class PreferencesState {}

class InitialPreference extends PreferencesState {}

class PreferencesSuccess extends PreferencesState {
  final List<PreferenceModel> response;
  final List<CategoryModel> results;
  PreferencesSuccess(this.response, this.results);
}

class PreferencesLoading extends PreferencesState {}

class PreferencesError extends PreferencesState {
  String error;
  PreferencesError(this.error);
}
