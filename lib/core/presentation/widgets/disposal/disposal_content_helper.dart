import 'package:flutter/material.dart';

class CategoryVisualConfig {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBgColor;
  final List<DisposalStepConfig> steps;

  const CategoryVisualConfig({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    this.iconBgColor,
    required this.steps,
  });
}

class DisposalStepConfig {
  final String stepNumber;
  final String title;
  final String fallbackDesc;
  final IconData icon;

  const DisposalStepConfig({
    required this.stepNumber,
    required this.title,
    required this.fallbackDesc,
    required this.icon,
  });
}

class DisposalContentHelper {
  static CategoryVisualConfig getConfig(
    String category,
    ColorScheme colorScheme,
  ) {
    final cat = category.trim().toLowerCase();

    // 1. Hazardous / E-Waste / Battery / Chemical
    if (cat.contains('hazard') ||
        cat.contains('battery') ||
        cat.contains('e-waste') ||
        cat.contains('electronic') ||
        cat.contains('toxic') ||
        cat.contains('chemical')) {
      return CategoryVisualConfig(
        title: 'Hazardous Waste',
        subtitle: 'Toxic materials require specialized drop-off centers.',
        icon: Icons.warning_amber_rounded,
        iconColor: const Color(0xFFD32F2F),
        iconBgColor: const Color(0xFFFFCDD2),
        steps: const [
          DisposalStepConfig(
            stepNumber: '1',
            title: 'Store safely in sealed container',
            fallbackDesc: 'Keep hazardous waste in a non-reactive, leak-proof container.',
            icon: Icons.shield_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '2',
            title: 'Do not mix or incinerate',
            fallbackDesc: 'Never mix chemicals or throw batteries into normal bins.',
            icon: Icons.local_fire_department_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '3',
            title: 'Take to hazardous collection point',
            fallbackDesc: 'Drop off at authorized e-waste or hazardous recycling kiosks.',
            icon: Icons.delete_forever_rounded,
          ),
        ],
      );
    }

    // 2. Organic
    if (cat.contains('organic') || cat.contains('bio') || cat.contains('food')) {
      return CategoryVisualConfig(
        title: 'Organic Waste',
        subtitle: 'Identify, separate and compost organic waste responsibly.',
        icon: Icons.eco_rounded,
        iconColor: colorScheme.primary,
        iconBgColor: colorScheme.primaryContainer,
        steps: const [
          DisposalStepConfig(
            stepNumber: '1',
            title: 'Separate organic items',
            fallbackDesc: 'Separate organic waste from non-compostable materials.',
            icon: Icons.water_drop_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '2',
            title: 'Check composting rules',
            fallbackDesc: 'Check which materials your composting service accepts.',
            icon: Icons.eco_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '3',
            title: 'Use approved green bin',
            fallbackDesc: 'Use an approved composting or organic waste collection method.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
      );
    }

    // 3. Paper
    if (cat.contains('paper') || cat.contains('cardboard')) {
      return CategoryVisualConfig(
        title: 'Paper Waste',
        subtitle: 'Keep dry and flat for efficient recycling.',
        icon: Icons.inventory_2_rounded,
        iconColor: colorScheme.secondary,
        iconBgColor: colorScheme.secondary.withOpacity(0.2),
        steps: const [
          DisposalStepConfig(
            stepNumber: '1',
            title: 'Keep dry and clean',
            fallbackDesc: 'Ensure paper is free of food grease and moisture.',
            icon: Icons.cleaning_services_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '2',
            title: 'Remove tape and clips',
            fallbackDesc: 'Strip off excessive plastic packaging tape and metal pins.',
            icon: Icons.content_cut_rounded,
          ),
          DisposalStepConfig(
            stepNumber: '3',
            title: 'Place in blue bin',
            fallbackDesc: 'Deposit in designated paper recycling containers.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
      );
    }

    // 4. Glass
    if (cat.contains('glass')) {
      return CategoryVisualConfig(
        title: 'Glass Waste',
        subtitle: 'Handle carefully and recycle without degradation.',
        icon: Icons.wine_bar_rounded,
        iconColor: colorScheme.secondary,
        iconBgColor: colorScheme.secondary.withOpacity(0.2),
        steps: const [
          DisposalStepConfig(
            stepNumber: '1',
            title: 'Rinse bottles clean',
            fallbackDesc: 'Rinse out leftovers and remove bottle caps.',
            icon: Icons.water_drop_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '2',
            title: 'Prevent glass breakage',
            fallbackDesc: 'Handle with care to protect collection workers.',
            icon: Icons.health_and_safety_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '3',
            title: 'Drop at glass depot',
            fallbackDesc: 'Place in specialized glass bins or drop-off centers.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
      );
    }

    // 5. Metal
    if (cat.contains('metal') || cat.contains('can')) {
      return CategoryVisualConfig(
        title: 'Metal Waste',
        subtitle: 'Endlessly recyclable to save raw natural energy.',
        icon: Icons.hardware_rounded,
        iconColor: colorScheme.secondary,
        iconBgColor: colorScheme.secondary.withOpacity(0.2),
        steps: const [
          DisposalStepConfig(
            stepNumber: '1',
            title: 'Empty and rinse',
            fallbackDesc: 'Clean out any beverage or food residues completely.',
            icon: Icons.water_drop_outlined,
          ),
          DisposalStepConfig(
            stepNumber: '2',
            title: 'Crush cans flat',
            fallbackDesc: 'Compress cans carefully to maximize bin capacity.',
            icon: Icons.compress_rounded,
          ),
          DisposalStepConfig(
            stepNumber: '3',
            title: 'Drop in metal recycling',
            fallbackDesc: 'Deposit inside the dry scrap or metal recycle bin.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
      );
    }

    // Default: Plastic
    return CategoryVisualConfig(
      title: 'Plastic Waste',
      subtitle: 'Identify, sort and recycle plastic responsibly.',
      icon: Icons.recycling_rounded,
      iconColor: colorScheme.secondary,
      iconBgColor: colorScheme.secondary.withOpacity(0.25),
      steps: const [
        DisposalStepConfig(
          stepNumber: '1',
          title: 'Empty and clean',
          fallbackDesc: 'Remove leftover liquids or food, and rinse when appropriate.',
          icon: Icons.water_drop_outlined,
        ),
        DisposalStepConfig(
          stepNumber: '2',
          title: 'Check the plastic type',
          fallbackDesc: 'Look for the recycling symbol and local acceptance rules.',
          icon: Icons.recycling_rounded,
        ),
        DisposalStepConfig(
          stepNumber: '3',
          title: 'Find the right bin',
          fallbackDesc: 'Use a recycling collection point that accepts that type of plastic.',
          icon: Icons.delete_outline_rounded,
        ),
      ],
    );
  }
}