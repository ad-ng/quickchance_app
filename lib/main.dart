import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/core/dark_mode.dart';
import 'package:quickchance_app/core/light_mode.dart';
import 'package:quickchance_app/core/theme_cubit.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/tokenstore.dart';
import 'package:quickchance_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:quickchance_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:quickchance_app/features/auth/presentation/pages/forgot_password.dart';
import 'package:quickchance_app/features/auth/presentation/pages/login_page.dart';
import 'package:quickchance_app/features/auth/presentation/pages/register_page.dart';
import 'package:quickchance_app/features/home/data/repositories/opps_repo_impl.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
import 'package:quickchance_app/features/home/presentation/pages/landing_page.dart';
import 'package:quickchance_app/features/notifications/presentation/pages/notification_page.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authRepo = AuthRepoImpl();
  final oppsRepo = OppsRepoImpl();
  final searchRepo = SearchRepoImpl();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(_authRepo)),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => OpportunityCubit(oppsRepo)),
        BlocProvider(create: (context) => SearchCubit(searchRepo)),
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
  ],
);
