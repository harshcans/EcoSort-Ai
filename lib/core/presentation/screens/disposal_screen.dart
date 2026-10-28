import 'package:flutter/material.dart';
import '../widgets/disposal/disposal_step_card.dart';
import '../widgets/disposal/result_header.dart';
import '../widgets/disposal/waste_success_card.dart';
import '../widgets/disposal/disposal_content_helper.dart';

class DisposalStepData {
  final String stepNumber;
  final String title;
  final String description;
  final IconData icon;

  DisposalStepData({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class DisposalScreen extends StatelessWidget {
  final String? category;
  final String? summary;
  final List<String>? rawSteps;

  const DisposalScreen({super.key, this.category, this.summary, this.rawSteps});

  String _getSvgForCategory(String category) {
    final cat = category.trim().toLowerCase();
    if (cat.contains('hazard') ||
        cat.contains('battery') ||
        cat.contains('e-waste') ||
        cat.contains('toxic') ||
        cat.contains('chemical')) {
      return 'assets/imageSvg/hazardous.svg';
    } else if (cat.contains('glass')) {
      return 'assets/imageSvg/Group 26 (3).svg';
    } else if (cat.contains('paper') || cat.contains('cardboard')) {
      return 'assets/imageSvg/Group 26 (1).svg';
    } else if (cat.contains('metal') || cat.contains('can')) {
      return 'assets/imageSvg/Group 26 (2).svg';
    } else if (cat.contains('organic') ||
        cat.contains('bio') ||
        cat.contains('food')) {
      return 'assets/imageSvg/Group_26_dark_green.svg';
    }
    return 'assets/imageSvg/Group 26 (4).svg'; // Plastic default
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Route arguments safe extraction (Dono support karega: constructor parameters + route arguments)
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String rawCat = (category != null && category!.trim().isNotEmpty)
        ? category!
        : (args?['category']?.toString() ?? 'plastic');

    final String effectiveCategory = rawCat.trim().isEmpty ? 'plastic' : rawCat;

    final String? effectiveSummary =
        (summary != null && summary!.trim().isNotEmpty)
        ? summary
        : args?['summary']?.toString();

    final List<String>? effectiveRawSteps =
        (rawSteps != null && rawSteps!.isNotEmpty)
        ? rawSteps
        : (args?['rawSteps'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList();

    // Category ke hisaab se dynamic visual config (Hazardous, Organic, Metal, etc.)
    final visualConfig = DisposalContentHelper.getConfig(
      effectiveCategory,
      colorScheme,
    );

    // Dynamic steps mapping: Backend steps + category icons
    final List<DisposalStepData> mappedSteps = visualConfig.steps
        .asMap()
        .entries
        .map((entry) {
          final idx = entry.key;
          final stepCfg = entry.value;

          String finalDesc = stepCfg.fallbackDesc;
          if (effectiveRawSteps != null &&
              idx < effectiveRawSteps.length &&
              effectiveRawSteps[idx].isNotEmpty) {
            finalDesc = effectiveRawSteps[idx];
          }

          return DisposalStepData(
            stepNumber: stepCfg.stepNumber,
            title: stepCfg.title,
            description: finalDesc,
            icon: stepCfg.icon,
          );
        })
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultHeader(
                category: effectiveCategory,
                subtitle:
                    (effectiveSummary != null && effectiveSummary.isNotEmpty)
                    ? effectiveSummary
                    : visualConfig.subtitle,
                icon: visualConfig.icon,
                iconColor: visualConfig.iconColor,
                iconBgColor: visualConfig.iconBgColor,
                onBack: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 20),
              WasteSuccessCard(
                title: '${visualConfig.title}\nDetected Successfully!!',
                svgPath: _getSvgForCategory(effectiveCategory),
              ),
              const SizedBox(height: 24),
              Text(
                'How to dispose',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ...mappedSteps.map(
                (step) => DisposalStepCard(
                  stepNumber: step.stepNumber,
                  title: step.title,
                  description: step.description,
                  icon: step.icon,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
