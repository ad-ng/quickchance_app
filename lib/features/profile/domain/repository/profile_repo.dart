import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/profile/data/model/preference_model.dart';

abstract class ProfileRepo {
  Future<UserModel?> getLocalUser();
  Future<List<PreferenceModel>> fetchPreferences();
}
