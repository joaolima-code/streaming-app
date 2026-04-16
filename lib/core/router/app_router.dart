import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/home/presentation/screen/splash_screen.dart';
import '../../features/movies/presentation/screens/movie_detail_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          }),
      GoRoute(
          path: '/movies',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          }),
      GoRoute(
          path: '/movie/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String? id = state.pathParameters['id'];
            return MovieDetailScreen(movieId: id);
          }),
      GoRoute(
          path: '/error',
          builder: (BuildContext context, GoRouterState state) {
            return const Scaffold(
                body: Center(child: Text('An error occurred')));
          })
    ],
  );
}
