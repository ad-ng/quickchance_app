import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/profile/domain/repository/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<UserModel?> getLocalUser() async {
    return await UserPreferences().getLocalUser();
  }
}
