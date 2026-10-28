// import 'package:ecosort/core/routes/app_routes.dart';
// import 'package:ecosort/features/scan/presentation/widgets/waste_category.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../widgets/home_header.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               HomeHeader(
//                 onNotificationTap: () {},
//                 onProfileTap: () {
//                   // Navigator.pushNamed(context, AppRoutes.settings);
//                 },
//               ),
//               const SizedBox(height: 20),
//               _buildHeroBanner(context, colorScheme),
//               const SizedBox(height: 26),
//               WasteCategoriesGrid(
//                 onCategoryTap: (categoryName) {
//                   // Category click handling
//                 },
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeroBanner(BuildContext context, ColorScheme colorScheme) {
//     const double buttonHeight = 46.0;

//     return Column(
//       children: [
//         Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.bottomCenter,
//           children: [
//             // Purple Container
//             Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               child: Container(
//                 height: 160,
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(bottom: buttonHeight / 2),
//                 padding: const EdgeInsets.fromLTRB(
//                   22,
//                   22,
//                   22,
//                   (buttonHeight / 2) + 14,
//                 ),
//                 decoration: BoxDecoration(
//                   color: colorScheme.secondaryContainer,
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Small actions\nmake a big\nimpact!',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           height: 1.25,
//                           color: colorScheme.primary,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 95,
//                       width: 90,
//                       child: SvgPicture.asset(
//                         'assets/imageSvg/Group 2 (1).svg',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Positioned(
//               bottom: 10,
//               left: 18,
//               right: 18,
//               height: buttonHeight,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, AppRoutes.scan);
//                 },
//                 icon: const Icon(Icons.photo_camera_outlined, size: 20),
//                 label: const Text(
//                   'Scan Waste',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: colorScheme.primary,
//                   foregroundColor: Colors.white,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: SizedBox(
//             width: double.infinity,
//             height: buttonHeight,
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 Navigator.pushNamed(context, AppRoutes.scan);
//               },
//               icon: Icon(
//                 Icons.image_outlined,
//                 size: 20,
//                 color: colorScheme.primary,
//               ),
//               label: Text(
//                 'Upload from Gallery',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 15,
//                   color: colorScheme.primary,
//                 ),
//               ),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: colorScheme.primary, width: 1.5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:ecosort/core/routes/app_routes.dart';
// import 'package:ecosort/features/scan/presentation/widgets/waste_category.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../widgets/home_header.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               HomeHeader(),
//               const SizedBox(height: 20),
//               _buildHeroBanner(context, colorScheme),
//               const SizedBox(height: 26),
//               WasteCategoriesGrid(
//                 onCategoryTap: (categoryName) {
//                   // Category click handling
//                 },
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeroBanner(BuildContext context, ColorScheme colorScheme) {
//     const double buttonHeight = 46.0;

//     return Column(
//       children: [
//         Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.bottomCenter,
//           children: [
//             // Purple Container
//             Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               child: Container(
//                 height: 160,
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(bottom: buttonHeight / 2),
//                 padding: const EdgeInsets.fromLTRB(
//                   22,
//                   22,
//                   22,
//                   (buttonHeight / 2) + 14,
//                 ),
//                 decoration: BoxDecoration(
//                   color: colorScheme.secondaryContainer,
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Small actions\nmake a big\nimpact!',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           height: 1.25,
//                           color: colorScheme.primary,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 95,
//                       width: 90,
//                       child: SvgPicture.asset(
//                         'assets/imageSvg/Group 2 (1).svg',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Positioned(
//               bottom: 10,
//               left: 18,
//               right: 18,
//               height: buttonHeight,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // Camera mode ke liye normal open
//                   Navigator.pushNamed(context, AppRoutes.scan);
//                 },
//                 icon: const Icon(Icons.photo_camera_outlined, size: 20),
//                 label: const Text(
//                   'Scan Waste',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: colorScheme.primary,
//                   foregroundColor: Colors.white,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: SizedBox(
//             width: double.infinity,
//             height: buttonHeight,
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   AppRoutes.scan,
//                   arguments: {'openGallery': true},
//                 );
//               },
//               icon: Icon(
//                 Icons.image_outlined,
//                 size: 20,
//                 color: colorScheme.primary,
//               ),
//               label: Text(
//                 'Upload from Gallery',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 15,
//                   color: colorScheme.primary,
//                 ),
//               ),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: colorScheme.primary, width: 1.5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:ecosort/core/routes/app_routes.dart';
import 'package:ecosort/features/scan/presentation/widgets/waste_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              _buildHeroBanner(context, colorScheme),
              const SizedBox(height: 26),
              WasteCategoriesGrid(
                onCategoryTap: (categoryName) {
                  // Category click handling
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, ColorScheme colorScheme) {
    const double buttonHeight = 46.0;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: 160,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: buttonHeight / 2),
                padding: const EdgeInsets.fromLTRB(
                  22,
                  22,
                  22,
                  (buttonHeight / 2) + 14,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Small actions\nmake a big\nimpact!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 95,
                      width: 90,
                      child: SvgPicture.asset(
                        'assets/imageSvg/Group 2 (1).svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 18,
              right: 18,
              height: buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.scan,
                    arguments: {'mode': 'camera'},
                  );
                },
                icon: const Icon(Icons.photo_camera_outlined, size: 20),
                label: const Text(
                  'Scan Waste',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.scan,
                  arguments: {'mode': 'gallery'},
                );
              },
              icon: Icon(
                Icons.image_outlined,
                size: 20,
                color: colorScheme.primary,
              ),
              label: Text(
                'Upload from Gallery',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: colorScheme.primary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colorScheme.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}