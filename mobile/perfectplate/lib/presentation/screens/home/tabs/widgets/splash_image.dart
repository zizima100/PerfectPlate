import 'package:flutter/material.dart';
import 'package:perfectplate/core/constants/strings.dart';

class PerfectPlateSplashImage extends StatelessWidget {
  const PerfectPlateSplashImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Image.asset(
        ImageConstants.logoImage,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
