import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/history_cubit.dart';
import '../../logic/history_state.dart';
import '../../data/model/scan_history_model.dart';
import '../widgets/history_card.dart';
import '../widgets/history_filler_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Plastic',
    'Organic',
    'Paper',
    'Glass',
    'Metal',
    'E-Waste',
  ];

  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().loadHistory();
  }

  // Safe Property Extractors
  String _extractId(ScanHistoryModel item, int fallbackIndex) {
    if (item.id.trim().isNotEmpty) return item.id;
    return '$fallbackIndex';
  }

  String _extractTitle(ScanHistoryModel item) {
    if (item.title.trim().isNotEmpty && item.title != 'Unknown Item') {
      return item.title;
    }
    return item.category;
  }

  String _extractCategory(ScanHistoryModel item) {
    if (item.category.toLowerCase() == 'general' ||
        item.category.trim().isEmpty) {
      return 'Organic';
    }
    return item.category;
  }

  void _showDisposalDetailDialog(BuildContext context, ScanHistoryModel item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final title = _extractTitle(item);
    final category = _extractCategory(item);

    Widget imageWidget = Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.recycling_rounded,
        size: 64,
        color: colorScheme.primary,
      ),
    );

    if (item.imagePath != null && item.imagePath!.trim().isNotEmpty) {
      if (!item.imagePath!.startsWith('http')) {
        final file = File(item.imagePath!);
        if (file.existsSync()) {
          imageWidget = ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              file,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        }
      } else {
        imageWidget = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            item.imagePath!,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => imageWidget,
          ),
        );
      }
    }

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.75,
              maxWidth: MediaQuery.of(ctx).size.width,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageWidget,
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (item.summary != null &&
                              item.summary!.isNotEmpty) ...[
                            Text(
                              item.summary!,
                              style: TextStyle(
                                fontSize: 13,
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withOpacity(0.75),
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 14),
                          ],
                          const Divider(),
                          const SizedBox(height: 10),
                          const Text(
                            'Guide to Dispose',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(item.steps.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: colorScheme.primary,
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item.steps[i],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
              child: Text(
                'Scan History',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.primary,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            HistoryFilterBar(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onSelected: (cat) {
                setState(() => _selectedCategory = cat);
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  }

                  if (state is HistoryError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: colorScheme.error),
                      ),
                    );
                  }

                  if (state is HistoryEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 68,
                            color: colorScheme.primary.withOpacity(0.3),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No scan history yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is HistoryLoaded) {
                    final filteredScans = _selectedCategory == 'All'
                        ? state.scans
                        : state.scans.where((scan) {
                            final cat = _extractCategory(scan).toLowerCase();
                            return cat.contains(
                              _selectedCategory.toLowerCase(),
                            );
                          }).toList();

                    if (filteredScans.isEmpty) {
                      return Center(
                        child: Text(
                          'No $_selectedCategory waste found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: colorScheme.primary,
                      onRefresh: () =>
                          context.read<HistoryCubit>().loadHistory(),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        itemCount: filteredScans.length,
                        itemBuilder: (context, index) {
                          final item = filteredScans[index];
                          final id = _extractId(item, index);
                          final title = _extractTitle(item);
                          final category = _extractCategory(item);

                          return Dismissible(
                            key: Key(id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            onDismissed: (_) {
                              context.read<HistoryCubit>().deleteScan(id);
                            },
                            child: HistoryCard(
                              title: title,
                              category: category,
                              confidence: item.confidence,
                              imagePath: item.imagePath,
                              onTap: () {
                                _showDisposalDetailDialog(context, item);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
