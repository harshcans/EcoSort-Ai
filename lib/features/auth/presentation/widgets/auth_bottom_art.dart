import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBottomArt extends StatelessWidget {
  const AuthBottomArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            'assets/imageSvg/Group 13.svg', // <-- Tera SVG path
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
