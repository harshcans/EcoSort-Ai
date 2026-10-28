// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class HomeHeader extends StatelessWidget {
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onProfileTap;

//   const HomeHeader({super.key, this.onNotificationTap, this.onProfileTap});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SvgPicture.asset('assets/imageSvg/Frame 22.svg', height: 38, width: 40),
//         const SizedBox(width: 8),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: onNotificationTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: SvgPicture.asset(
//                   'assets/imageSvg/akar-icons_bell (1).svg',
//                   height: 29,
//                   width: 24,
//                   colorFilter: ColorFilter.mode(
//                     colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: onProfileTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: SvgPicture.asset(
//                   'assets/imageSvg/andrsrxn_user-circle.svg',
//                   height: 29,
//                   width: 24,
//                   colorFilter: ColorFilter.mode(
//                     colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../auth/logic/auth_cubit.dart';
// import '../../../auth/logic/auth_state.dart';

// class HomeHeaderActions {
//   // 1. Notification Tap: Beep sound + Dialog jisme "No notification" likha ho
//   static void onNotificationPressed(BuildContext context) {
//     SystemSound.play(SystemSoundType.click);

//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.notifications_none_rounded, color: colorScheme.primary),
//             const SizedBox(width: 10),
//             const Text(
//               'Notifications',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         content: const Text(
//           'No notification',
//           style: TextStyle(fontSize: 15),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: Text(
//               'OK',
//               style: TextStyle(
//                 color: colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 2. Profile Tap: Dialog jisme CircleAvatar (name ka pehla letter), Name aur Email ho
//   static void onProfilePressed(BuildContext context) {
//     final authState = context.read<AuthCubit>().state;
//     String name = 'User';
//     String email = 'user@ecosort.ai';

//     if (authState is AuthAuthenticated && authState.user != null) {
//       final user = authState.user;
//       final rawName = (user.name ?? '').toString().trim();
//       final rawEmail = (user.email ?? '').toString().trim();

//       if (rawEmail.isNotEmpty) {
//         email = rawEmail;
//       }

//       if (rawName.isNotEmpty && rawName.toLowerCase() != 'user') {
//         name = rawName;
//       } else if (rawEmail.contains('@')) {
//         // Agar Google se login hai ya name khali hai -> email ke @ se pehle ka name
//         name = rawEmail.split('@').first;
//       }
//     }

//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final firstLetter = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : 'U';

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Circle Avatar jisme name ka pehla word/letter ho
//             CircleAvatar(
//               radius: 36,
//               backgroundColor: colorScheme.primary,
//               child: Text(
//                 firstLetter,
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // User Name
//             Text(
//               name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 6),

//             // User Email
//             Text(
//               email,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: Text(
//               'Close',
//               style: TextStyle(
//                 color: colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../auth/logic/auth_cubit.dart';
// import '../../../auth/logic/auth_state.dart';

// class HomeHeader extends StatelessWidget {
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onProfileTap;

//   const HomeHeader({super.key, this.onNotificationTap, this.onProfileTap});

//   // 1. Notification Tap: Beep sound + Dialog "No notification"
//   void _showNotificationDialog(BuildContext context) {
//     SystemSound.play(SystemSoundType.click);

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         content: const Text(
//           'No notification',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // 2. Profile Tap: Dialog with CircleAvatar, Name, and Email
//   void _showProfileDialog(BuildContext context) {
//     final authState = context.read<AuthCubit>().state;
//     String name = '';
//     String email = '';

//     if (authState is AuthAuthenticated && authState.user != null) {
//       final user = authState.user;
//       final rawName = (user.name ?? '').toString().trim();
//       final rawEmail = (user.email ?? '').toString().trim();

//       email = rawEmail;

//       if (rawName.isNotEmpty && rawName.toLowerCase() != 'user') {
//         name = rawName;
//       } else if (rawEmail.contains('@')) {
//         name = rawEmail.split('@').first;
//       }
//     }

//     if (name.isEmpty) name = 'User';
//     if (email.isEmpty) email = 'user@ecosort.ai';

//     final firstLetter = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : 'U';

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 12),
//             CircleAvatar(
//               radius: 36,
//               child: Text(
//                 firstLetter,
//                 style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               name,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               email,
//               style: const TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SvgPicture.asset('assets/imageSvg/Frame 22.svg', height: 38, width: 40),
//         const SizedBox(width: 8),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: onNotificationTap ?? () => _showNotificationDialog(context),
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: SvgPicture.asset(
//                   'assets/imageSvg/akar-icons_bell (1).svg',
//                   height: 29,
//                   width: 24,
//                   colorFilter: ColorFilter.mode(
//                     colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: onProfileTap ?? () => _showProfileDialog(context),
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: SvgPicture.asset(
//                   'assets/imageSvg/andrsrxn_user-circle.svg',
//                   height: 29,
//                   width: 24,
//                   colorFilter: ColorFilter.mode(
//                     colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../auth/logic/auth_state.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, this.onNotificationTap, this.onProfileTap});

  // 1. Notification Tap: Beep + No notification dialog
  void _showNotificationDialog(BuildContext context) {
    SystemSound.play(SystemSoundType.click);

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            Icon(Icons.notifications_active, color: primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              'Notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        content: const Text(
          'No notification',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'OK',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Profile Tap: Row with CircleAvatar + Column of Name & Email
  void _showProfileDialog(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    String name = '';
    String email = '';

    if (authState is AuthAuthenticated && authState.user != null) {
      final user = authState.user;
      final rawName = user.name.trim();
      final rawEmail = user.email.trim();

      if (rawEmail.isNotEmpty) {
        email = rawEmail;
      }

      if (rawName.isNotEmpty && rawName.toLowerCase() != 'user') {
        name = rawName;
      } else if (rawEmail.contains('@')) {
        final prefix = rawEmail.split('@').first;
        name = prefix.isNotEmpty
            ? prefix[0].toUpperCase() + prefix.substring(1)
            : 'Eco Warrior';
      }
    }

    if (name.isEmpty) name = 'Eco Warrior';
    if (email.isEmpty) email = 'user@ecosort.ai';

    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : 'E';
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.only(left: 50, right: 50, top: 40),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Solid Sharp CircleAvatar
            CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor,
              child: Text(
                firstLetter,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Column: Name & Email
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Close',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/imageSvg/Frame 22.svg', height: 38, width: 40),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap:
                  onNotificationTap ?? () => _showNotificationDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/imageSvg/akar-icons_bell (1).svg',
                  height: 29,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onProfileTap ?? () => _showProfileDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/imageSvg/andrsrxn_user-circle.svg',
                  height: 29,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
