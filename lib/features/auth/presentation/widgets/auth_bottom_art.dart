import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBottomArt extends StatelessWidget {
  const AuthBottomArt({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SvgPicture.asset(
          'assets/imageSvg/Group 13.svg',
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
