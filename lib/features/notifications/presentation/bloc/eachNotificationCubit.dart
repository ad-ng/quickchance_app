import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationApiService.dart';
import 'package:quickchance_app/features/notifications/data/models/userNotification.dart';

class EachNotificationCubit extends Cubit<EachNotificationState> {
  final NotificationApiService _notificationApiService;
  EachNotificationCubit(this._notificationApiService)
    : super(EachNotificationInitial()) {
    fetchAllUserNotifications();
  }

  Future fetchAllUserNotifications() async {
    emit(EachNotificationLoading());
    try {
      final response = await _notificationApiService.fetchAllUserNotification();
      emit(EachNotificationSuccess(response));
    } catch (e) {
      emit(EachNotificationError(e.toString()));
    }
  }
}

abstract class EachNotificationState {}

class EachNotificationInitial extends EachNotificationState {}

class EachNotificationLoading extends EachNotificationState {}

class EachNotificationSuccess extends EachNotificationState {
  final List<UserNotification> response;
  EachNotificationSuccess(this.response);
}

class EachNotificationError extends EachNotificationState {
  final String error;
  EachNotificationError(this.error);
}
