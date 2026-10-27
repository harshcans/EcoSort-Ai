import 'package:ecosort/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/theme_state.dart';
import 'features/auth/logic/auth_cubit.dart';
import 'features/history/logic/history_cubit.dart';
import 'features/scan/logic/scan_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('scan_history_box');

  await ServiceLocator.setup(isMockMode: false);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<ScanCubit>(
          create: (context) => ServiceLocator.createScanCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) =>
              ServiceLocator.createAuthCubit(),
        ),
        BlocProvider<HistoryCubit>(
          create: (context) => ServiceLocator.createHistoryCubit(),
        ),
      ],
      child: const EcoSortApp(),
    ),
  );
}

class EcoSortApp extends StatelessWidget {
  const EcoSortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EcoSort AI',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          // home: MainNavigationShell(),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
