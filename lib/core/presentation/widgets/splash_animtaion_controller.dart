import 'package:flutter/material.dart';

class SplashAnimationController {
  final TickerProvider vsync;

  // Entrance Controller (One-time on screen start)
  late final AnimationController enterController;

  // Ambient Idle Controller (Continuous subtle float for illustration)
  late final AnimationController floatController;

  // 1. Top Logo Animations
  late final Animation<double> logoFade;
  late final Animation<Offset> logoSlide;

  // 2. Center Illustration Animations
  late final Animation<double> illustrationFade;
  late final Animation<double> illustrationScale;
  late final Animation<Offset> illustrationFloat;

  // 3. Bottom CTAs Animations
  late final Animation<double> actionsFade;
  late final Animation<Offset> actionsSlide;

  SplashAnimationController({required this.vsync}) {
    // Entrance setup (1200ms)
    enterController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    // Continuous floating setup (2400ms repeating reverse)
    floatController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2400),
    );

    // Logo drops gently from top (-0.2 -> 0.0)
    logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );
    logoSlide = Tween<Offset>(
      begin: const Offset(0.0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.0, 0.50, curve: Curves.easeOutCubic),
      ),
    );

    // Center Illustration smooth scale-pop
    illustrationFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.25, 0.70, curve: Curves.easeIn),
      ),
    );
    illustrationScale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOutBack),
      ),
    );

    // Continuous floating tween (moves up and down by 8-10px)
    illustrationFloat = Tween<Offset>(
      begin: const Offset(0.0, -0.015),
      end: const Offset(0.0, 0.02),
    ).animate(
      CurvedAnimation(
        parent: floatController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Actions smooth slide-up
    actionsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
      ),
    );
    actionsSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Trigger entrance, then loop the subtle floating
    enterController.forward().then((_) {
      floatController.repeat(reverse: true);
    });
  }

  void dispose() {
    enterController.dispose();
    floatController.dispose();
  }
}