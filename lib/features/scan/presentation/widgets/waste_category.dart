import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WasteCategoriesGrid extends StatelessWidget {
  final Function(String category)? onCategoryTap;

  const WasteCategoriesGrid({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final categories = [
      {
        'svgPath': 'assets/imageSvg/Group 26 (4).svg', // plastic
        'isOrganic': false,
      },
      {
        'svgPath': 'assets/imageSvg/Group 26 (3).svg', // glass
        'isOrganic': false,
      },
      {
        'svgPath': 'assets/imageSvg/Group_26_dark_green.svg',
        'isOrganic': true, // primaryContainer (greenwaste)
      },
      {'svgPath': 'assets/imageSvg/Group 26 (1).svg', 'isOrganic': false},
      {'svgPath': 'assets/imageSvg/Group 26 (2).svg', 'isOrganic': false},
      {'svgPath': 'assets/imageSvg/hazardous.svg', 'isOrganic': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waste Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];
            final bool isOrganic = item['isOrganic'] as bool;

            final cardBg = isOrganic
                ? colorScheme.primaryContainer
                : colorScheme.secondaryContainer;

            return InkWell(
              borderRadius: BorderRadius.circular(18),
              // onTap: () {
              //   // onCategoryTap?.call(item['title'] as String);
              // },
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SVG Icon Renderer
                    SvgPicture.asset(
                      item['svgPath'] as String,
                      height: 70,
                      width: 60,
                      // Agar SVG single-color hai toh colorScheme.secondary se tint kar sakta hai:
                      // colorFilter: ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   item['title'] as String,
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     color: colorScheme.secondary,
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
