// import 'package:flutter/material.dart';

// class StatsUserCard extends StatelessWidget {
//   final String name;
//   final String email;
//   final String badgeText;
//   final String quote;

//   const StatsUserCard({
//     super.key,
//     this.name = 'Nikhil kumar',
//     this.email = 'nikki@ecosort.com',
//     this.badgeText = 'Eco Warrior',
//     this.quote = 'Small actions make a big difference',
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 34,
//               backgroundColor: colorScheme.primary,
//               child: Icon(
//                 Icons.person,
//                 size: 40,
//                 color: colorScheme.onPrimary,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.w800,
//                         color: colorScheme.primary,
//                       ) ??
//                       TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w800,
//                         color: colorScheme.primary,
//                       ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   email,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colorScheme.secondary,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 18),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: colorScheme.primary.withOpacity(0.12),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.auto_awesome,
//                 color: colorScheme.primary,
//                 size: 15,
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 badgeText,
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w700,
//                   color: colorScheme.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           quote,
//           style: TextStyle(
//             color: colorScheme.secondary,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth/logic/auth_cubit.dart';
import '../../../../features/auth/logic/auth_state.dart';

class StatsUserCard extends StatelessWidget {
  final String badgeText;
  final String quote;

  const StatsUserCard({
    super.key,
    this.badgeText = 'Eco Warrior',
    this.quote = 'Small actions make a big difference',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Logged-in user ka real name fetch karna
    final authState = context.watch<AuthCubit>().state;
    String name = 'Nikhil kumar';

    if (authState is AuthAuthenticated && authState.user != null) {
      final rawName = authState.user!.name.trim();
      final rawEmail = authState.user!.email.trim();

      if (rawName.isNotEmpty && rawName.toLowerCase() != 'user') {
        name = rawName;
      } else if (rawEmail.contains('@')) {
        final prefix = rawEmail.split('@').first;
        name = prefix.isNotEmpty
            ? prefix[0].toUpperCase() + prefix.substring(1)
            : 'Nikhil kumar';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar aur Email gayab -> Sirf real name + your contribution
        Text(
          '$name - Your contribution',
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
                fontSize: 22,
              ) ??
              TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
              ),
        ),
        const SizedBox(height: 14),
        // Eco Warrior Badge (Same to same)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                color: colorScheme.primary,
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                badgeText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Quote Text (Same to same)
        Text(
          quote,
          style: TextStyle(
            color: colorScheme.secondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}