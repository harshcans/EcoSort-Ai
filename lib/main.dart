// import 'package:ecosort/features/scan/presentation/screens/scan_identifying_screen.dart';
// import 'package:ecosort/features/scan/presentation/screens/scan_result_screen.dart';
// import 'package:ecosort/features/scan/presentation/screens/scan_screen.dart';
// import 'package:ecosort/features/scan/presentation/widgets/navigation_bar.dart';
// import 'package:ecosort/features/scan/presentation/screens/home_screen.dart';
// import 'package:ecosort/features/scan/presentation/widgets/navigation_bar.dart';
import 'package:ecosort/features/scan/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/routes/app_router.dart';
// import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/theme_state.dart';
import 'features/auth/logic/auth_cubit.dart';
import 'features/history/logic/history_cubit.dart';
import 'features/scan/logic/scan_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences initialization ke liye await zaroori hai
  await ServiceLocator.setup(isMockMode: true);

  runApp(
    MultiBlocProvider(
      providers: [
        // 0. Theme Cubit
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),

        // 1. Scan Feature Cubit
        BlocProvider<ScanCubit>(
          create: (context) => ServiceLocator.createScanCubit(),
        ),

        // 2. Auth Feature Cubit
        BlocProvider<AuthCubit>(
          create: (context) => ServiceLocator.createAuthCubit(),
        ),

        // 3. History Feature Cubit
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
          // home: const MainNavigationShell(),
          home: MainNavigationShell(),
          // home: ScanIdentifyingScreen(),
          // home : ScanResultScreen(),
          // initialRoute: AppRoutes.auth,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
