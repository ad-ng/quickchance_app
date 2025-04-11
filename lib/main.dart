import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quick Chance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(name: '/', path: '/', builder: (context, state) => LoginPage()),
    GoRoute(
      name: 'login',
      path: 'login',
      builder: (context, state) => LoginPage(),
    ),
  ],
);
