import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:wrd/core/services/screen_size_helper.dart';

class FrostedGlassAudio extends StatelessWidget {
  const FrostedGlassAudio({
    super.key,
    required this.theChild, required this.theHeight,
  });
  final theChild;
  final  double theHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: // icon-Rectangle 39347
          Container(
        height: theHeight,
        width: 240.width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Center(
                  child: theChild,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
