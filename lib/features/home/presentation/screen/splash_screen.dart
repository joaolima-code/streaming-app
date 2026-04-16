import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typogaphy.dart';
import '../cubit/home_config_cubit.dart';
import '../cubit/home_config_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    GetIt.instance<HomeConfigCubit>().init();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    _checkConfigHomeNavigation();
  }

  Future<void> _checkConfigHomeNavigation() async {
    final HomeConfigCubit homeConfigCubit = GetIt.instance<HomeConfigCubit>();

    final Future<dynamic> delayedVisualSplash = Future<dynamic>.delayed(
      const Duration(seconds: 2),
    );

    Future<void> waitForConfig;
    if (homeConfigCubit.state is HomeConfigSuccess ||
        homeConfigCubit.state is HomeConfigError) {
      waitForConfig = Future<void>.value();
    } else {
      waitForConfig = homeConfigCubit.stream
          .firstWhere(
            (HomeConfigState state) =>
                state is HomeConfigSuccess || state is HomeConfigError,
          )
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => const HomeConfigError('Timeout'),
          );
    }

    await Future.wait(<Future<void>>[delayedVisualSplash, waitForConfig]);

    if (!mounted) {
      return;
    }

    if (homeConfigCubit.state is HomeConfigSuccess) {
      context.go('/movies');
    } else if (homeConfigCubit.state is HomeConfigInitial) {
    } else {
      context.go('/error');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.movie_filter_rounded,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Streaming Films',
                        style: AppTypography.displayLarge.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Os melhores filmes para você assistir',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 48),
                      const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
