import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/home/presentation/cubit/home_config_cubit.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class CoreAppWidget extends StatelessWidget {
  const CoreAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeConfigCubit>(
      create: (_) {
        final HomeConfigCubit homeConfigCubit =
            GetIt.instance<HomeConfigCubit>();

        homeConfigCubit.init();
        return homeConfigCubit;
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
