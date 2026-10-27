import 'dart:io';
import 'package:ecosort/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../widgets/waste_category_card.dart';
import '../widgets/scan_action_button.dart';

class ScanResultScreen extends StatelessWidget {
  final File? scannedImage;
  final String category;
  final String? description;
  final List<String>? steps;

  const ScanResultScreen({
    super.key,
    this.scannedImage,
    this.category = 'other',
    this.description,
    this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final descText =
        description ??
        'This item belongs to the ${category.toLowerCase()} category.';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Scan Result',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Image Preview
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 260,
                  width: double.infinity,
                  color: colorScheme.surfaceContainerHighest,
                  child: scannedImage != null
                      ? Image.file(
                          scannedImage!,
                          fit: BoxFit.cover,
                          cacheWidth: 800,
                        )
                      : Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 60,
                            color: colorScheme.onSurface.withOpacity(0.3),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 18),
              WasteCategoryCard(category: category),
              const SizedBox(height: 20),
              Text(
                descText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),

              // Steps from backend guidance
              if (steps != null && steps!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Steps to Follow:',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ...steps!.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${e.key + 1}. ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            e.value,
                            style: const TextStyle(fontSize: 14, height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              ScanActionButtons(
                onDisposalGuideTap: () {
                  Navigator.pushNamed(context, AppRoutes.disposalpage);
                },
                onScanWasteTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
