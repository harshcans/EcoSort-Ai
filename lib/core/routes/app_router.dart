import 'package:ecosort/core/presentation/screens/disposal_screen.dart';
import 'package:ecosort/core/presentation/screens/splash_screen.dart';
import 'package:ecosort/features/scan/presentation/screens/scan_identifying_screen.dart';
import 'package:ecosort/features/scan/presentation/screens/scan_screen.dart';
import 'package:ecosort/features/scan/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/otp_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      case AppRoutes.otp:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(builder: (_) => OtpScreen(email: email));

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainNavigationShell());
      case AppRoutes.scan:
        return MaterialPageRoute(builder: (_) => const ScanScreen());
      case AppRoutes.scanresult:
        return MaterialPageRoute(builder: (_) => const ScanIdentifyingScreen());
      case AppRoutes.disposalpage:
        return MaterialPageRoute(builder: (_) => const DisposalScreen());

      case AppRoutes.history:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'History Screen Placeholder',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
