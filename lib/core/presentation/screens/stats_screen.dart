import 'package:flutter/material.dart';
import '../../services/history_service.dart';
import '../widgets/stats_counter_card.dart';
import '../widgets/stats_category_chart.dart';
import '../widgets/stats_user_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int totalScans = 0;
  int recycledCount = 0;
  double co2Saved = 0.0;

  Map<String, int> categoryCounts = {
    'Plastic': 0,
    'Paper': 0,
    'Glass': 0,
    'Metal': 0,
    'Organic': 0,
    'E-Waste': 0,
  };

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    final scans = HistoryService.getAllScans();
    totalScans = scans.length;
    recycledCount = scans.length;
    co2Saved = totalScans * 0.2;

    final Map<String, int> counts = {
      'Plastic': 0,
      'Paper': 0,
      'Glass': 0,
      'Metal': 0,
      'Organic': 0,
      'E-Waste': 0,
    };

    for (var scan in scans) {
      final category = (scan['category'] ?? '').toString().toLowerCase();
      if (category.contains('plastic')) {
        counts['Plastic'] = (counts['Plastic'] ?? 0) + 1;
      } else if (category.contains('paper')) {
        counts['Paper'] = (counts['Paper'] ?? 0) + 1;
      } else if (category.contains('glass')) {
        counts['Glass'] = (counts['Glass'] ?? 0) + 1;
      } else if (category.contains('metal')) {
        counts['Metal'] = (counts['Metal'] ?? 0) + 1;
      } else if (category.contains('organic')) {
        counts['Organic'] = (counts['Organic'] ?? 0) + 1;
      } else if (category.contains('e-waste') || category.contains('ewaste')) {
        counts['E-Waste'] = (counts['E-Waste'] ?? 0) + 1;
      }
    }

    setState(() {
      categoryCounts = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const StatsUserCard(),
              const SizedBox(height: 16),
              StatsCounterCard(
                totalScans: totalScans,
                recycled: recycledCount,
                co2SavedKg: co2Saved,
              ),
              const SizedBox(height: 24),
              StatsCategoryChart(
                categoryCounts: categoryCounts,
                totalScans: totalScans,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
