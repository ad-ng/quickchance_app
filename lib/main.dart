import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/conf/socketServices.dart';
import 'package:quickchance_app/core/dark_mode.dart';
import 'package:quickchance_app/core/light_mode.dart';
import 'package:quickchance_app/core/theme_cubit.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/tokenstore.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:quickchance_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:quickchance_app/features/auth/presentation/pages/forgot_password.dart';
import 'package:quickchance_app/features/auth/presentation/pages/login_page.dart';
import 'package:quickchance_app/features/auth/presentation/pages/register_page.dart';
import 'package:quickchance_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunitySocketService.dart';
import 'package:quickchance_app/features/home/data/repositories/opps_repo_impl.dart';
import 'package:quickchance_app/features/home/presentation/bloc/commentCubit.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
import 'package:quickchance_app/features/home/presentation/pages/comment_page.dart';
import 'package:quickchance_app/features/home/presentation/pages/landing_page.dart';
import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationApiService.dart';
import 'package:quickchance_app/features/notifications/presentation/bloc/eachNotificationCubit.dart';
import 'package:quickchance_app/features/notifications/presentation/pages/notification_page.dart';
import 'package:quickchance_app/features/profile/presentation/bloc/profilecubit.dart';
import 'package:quickchance_app/features/profile/presentation/pages/changePassword.dart';
import 'package:quickchance_app/features/profile/presentation/pages/editProfile.dart';
import 'package:quickchance_app/features/profile/presentation/pages/settingsPage.dart';
import 'package:quickchance_app/features/search/data/repository/search_repo_impl.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';

var tokenValue;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioService.instance.setup();
  tokenValue = await TokenStore.getToken();
  SocketService().connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authRepo = AuthRepoImpl();
  final oppsRepo = OppsRepoImpl();
  final searchRepo = SearchRepoImpl();
  final socketService = OpportunitySocketService();
  final _userPreferences = UserPreferences();
  final _notificationApiService = NotificationApiService();
  @override
  Widget build(BuildContext context) {
    print('app running');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(_authRepo)),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => OpportunityCubit(oppsRepo)),
        BlocProvider(create: (context) => SearchCubit(searchRepo)),
        BlocProvider(create: (context) => CommentCubit(oppsRepo)),
        BlocProvider(create: (context) => ProfileCubit(_userPreferences)),
        BlocProvider(
          create: (context) => EachNotificationCubit(_notificationApiService),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeModeState>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Quick Chance',
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:
                themeMode == ThemeModeState.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: '/',
      path: '/',
      builder:
          (context, state) =>
              (tokenValue == null) ? LoginPage() : LandingPage(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      name: 'landingPage',
      path: '/landingPage',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      name: 'changePassword',
      path: '/changePassword',
      builder: (context, state) => ChangePassword(),
    ),
    GoRoute(
      name: 'editProfile',
      path: '/editProfile',
      builder: (context, state) => EditProfile(),
    ),
    GoRoute(
      name: 'settingsPage',
      path: '/settingsPage',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      name: 'forgotPassword',
      path: '/forgotPassword',
      builder: (context, state) => ForgotPassword(),
    ),
    GoRoute(
      name: 'notificationPage',
      path: '/notificationPage',
      builder: (context, state) => NotificationPage(),
    ),
    GoRoute(
      name: 'dashboardPage',
      path: '/dashboardPage',
      builder: (context, state) => DashboardPage(),
    ),
    GoRoute(
      name: 'commentPage',
      path: '/commentPage/:oppId',
      builder: (context, state) {
        final int oppId = int.parse(state.pathParameters['oppId']!);
        return CommentPage(oppId: oppId);
      },
    ),
  ],
);
