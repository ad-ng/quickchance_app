import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/profile/data/model/preference_model.dart';
import 'package:quickchance_app/features/profile/domain/repository/profile_repo.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final ProfileRepo profileRepo;
  PreferencesCubit(this.profileRepo) : super(InitialPreference()) {
    getPreferences();
  }

  Future getPreferences() async {
    emit(PreferencesLoading());
    try {
      final response = await profileRepo.fetchPreferences();
      emit(PreferencesSuccess(response));
    } catch (e) {
      emit(PreferencesError(e.toString()));
    }
  }
}

abstract class PreferencesState {}

class InitialPreference extends PreferencesState {}

class PreferencesSuccess extends PreferencesState {
  final List<PreferenceModel> response;
  PreferencesSuccess(this.response);
}

class PreferencesLoading extends PreferencesState {}

class PreferencesError extends PreferencesState {
  String error;
  PreferencesError(this.error);
}
