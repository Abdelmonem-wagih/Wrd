import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({
    super.key,
    required this.theChild,
    required this.theWidth,
    required this.theHeight,
    required this.theBoraderRight,
    required this.theBoraderLeft,
  });
  final theChild;
  final double theWidth;
  final double theHeight;
  final double theBoraderRight;
  final double theBoraderLeft;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(theBoraderLeft),
        topLeft: Radius.circular(theBoraderLeft),
        topRight: Radius.circular(theBoraderRight),
        bottomRight: Radius.circular(theBoraderRight),
      ),
      child: Container(
        height: theHeight,
        width: theWidth,
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(theBoraderLeft),
                    topLeft: Radius.circular(theBoraderLeft),
                    topRight: Radius.circular(theBoraderRight),
                    bottomRight: Radius.circular(theBoraderRight),
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
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
