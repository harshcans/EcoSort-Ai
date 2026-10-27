import 'package:flutter/material.dart';
import '../widgets/disposal/disposal_step_card.dart';
import '../widgets/disposal/result_header.dart';
import '../widgets/disposal/waste_success_card.dart';

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
  final String category;
  final String? summary;
  final List<String>? rawSteps;

  const DisposalScreen({
    super.key,
    this.category = 'plastic',
    this.summary,
    this.rawSteps,
  });

  List<DisposalStepData> _getMappedSteps() {
    final defaultSteps = [
      DisposalStepData(
        stepNumber: '1',
        title: 'Empty and clean',
        description:
            'Remove leftover liquids or food, and rinse when appropriate.',
        icon: Icons.water_drop_outlined,
      ),
      DisposalStepData(
        stepNumber: '2',
        title: 'Check the plastic type',
        description:
            'Look for the recycling symbol and local acceptance rules.',
        icon: Icons.recycling_rounded,
      ),
      DisposalStepData(
        stepNumber: '3',
        title: 'Find the right bin',
        description:
            'Use a recycling collection point that accepts that type of plastic.',
        icon: Icons.delete_outline_rounded,
      ),
    ];

    if (rawSteps == null || rawSteps!.isEmpty) {
      return defaultSteps;
    }

    return rawSteps!.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final text = entry.value;

      String title = 'Step $index';
      String desc = text;

      if (text.contains(':')) {
        final parts = text.split(':');
        title = parts[0].trim();
        desc = parts.sublist(1).join(':').trim();
      }

      IconData icon = Icons.check_circle_outline;
      final lower = text.toLowerCase();
      if (lower.contains('clean') ||
          lower.contains('rinse') ||
          lower.contains('liquid') ||
          lower.contains('empty')) {
        icon = Icons.water_drop_outlined;
      } else if (lower.contains('check') ||
          lower.contains('type') ||
          lower.contains('symbol') ||
          lower.contains('recycle')) {
        icon = Icons.recycling_rounded;
      } else if (lower.contains('bin') ||
          lower.contains('point') ||
          lower.contains('drop') ||
          lower.contains('find')) {
        icon = Icons.delete_outline_rounded;
      }

      return DisposalStepData(
        stepNumber: '$index',
        title: title,
        description: desc,
        icon: icon,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final steps = _getMappedSteps();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultHeader(
                category: category,
                subtitle:
                    summary ??
                    'Identify, sort and recycle $category responsibly.',
                onBack: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 20),
              const WasteSuccessCard(),
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
              ...steps.map(
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
