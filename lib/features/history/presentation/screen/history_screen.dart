import 'package:flutter/material.dart';
import '../../../../core/services/history_service.dart';
import '../widgets/history_card.dart';
import '../widgets/history_filler_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _scans = [];
  bool _isLoading = true;

  final List<String> _categories = [
    'All',
    'Plastic',
    'Paper',
    'Glass',
    'Metal',
    'E-Waste',
  ];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    setState(() => _isLoading = true);
    final data = HistoryService.getAllScans();
    setState(() {
      _scans = data;
      _isLoading = false;
    });
  }

  String _formatTimestamp(dynamic rawDate) {
    if (rawDate == null) return 'Today, 2:15 PM';
    try {
      final dt = DateTime.parse(rawDate.toString());
      final now = DateTime.now();
      final timeStr =
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

      if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
        return 'Today, $timeStr';
      }
      return '${dt.day}/${dt.month}/${dt.year}, $timeStr';
    } catch (_) {
      return rawDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final filteredScans = _selectedCategory == 'All'
        ? _scans
        : _scans.where((scan) {
            final cat = (scan['category'] ?? '').toString().toLowerCase();
            return cat.contains(_selectedCategory.toLowerCase());
          }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Scan History',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (_scans.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: colorScheme.primary,
                      ),
                      tooltip: 'Clear History',
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Clear History'),
                            content: const Text(
                              'Are you sure you want to delete all saved scan records?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await HistoryService.clearHistory();
                          _loadHistory();
                        }
                      },
                    ),
                ],
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
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    )
                  : filteredScans.isEmpty
                      ? Center(
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
                                _selectedCategory == 'All'
                                    ? 'No scan history yet'
                                    : 'No $_selectedCategory waste found',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          itemCount: filteredScans.length,
                          itemBuilder: (context, index) {
                            final item = filteredScans[index];
                            final category = item['category'] ?? 'Plastic';
                            final title = item['itemName'] ?? '$category Item';
                            final confidence =
                                (item['confidence'] as num?)?.toDouble() ??
                                    0.95;
                            final timestamp =
                                _formatTimestamp(item['timestamp']);

                            return HistoryCard(
                              title: title,
                              category: category,
                              confidence: confidence,
                              timestamp: timestamp,
                              points: 5,
                              onTap: () {},
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}