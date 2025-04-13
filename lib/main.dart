import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:quickchance_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:quickchance_app/features/auth/presentation/pages/login_page.dart';
import 'package:quickchance_app/features/auth/presentation/pages/register_page.dart';
import 'package:quickchance_app/features/home/presentation/pages/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioService.instance.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authRepo = AuthRepoImpl();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit(_authRepo))],
      child: MaterialApp.router(
        title: 'Quick Chance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(name: '/', path: '/', builder: (context, state) => LoginPage()),
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
  ],
);
