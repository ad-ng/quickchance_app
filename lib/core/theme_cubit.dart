import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModeState { light, dark }

class ThemeCubit extends Cubit<ThemeModeState> {
  ThemeCubit() : super(ThemeModeState.light);

  // Toggle between light and dark theme
  void toggleTheme() {
    if (state == ThemeModeState.light) {
      emit(ThemeModeState.dark);
    } else {
      emit(ThemeModeState.light);
    }
  }
}
