import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserPreferences _userPreferences;
  ProfileCubit(this._userPreferences) : super(ProfileInitial()) {
    getLocalUser();
  }

  Future getLocalUser() async {
    emit(ProfileLoading());

    try {
      final response = await _userPreferences.getLocalUser();
      emit(ProfileSuccess(response!));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel response;
  ProfileSuccess(this.response);
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}
