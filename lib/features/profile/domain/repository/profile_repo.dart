import 'package:quickchance_app/features/auth/data/model/user_model.dart';

abstract class ProfileRepo {
  Future<UserModel?> getLocalUser();
}
