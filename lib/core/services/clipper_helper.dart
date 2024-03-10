import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*1.0039800,size.height*-0.0056024);
    path_0.lineTo(size.width*1.0133000,size.height*1.0007952);
    path_0.lineTo(size.width*0.9020000,size.height*1.0012048);
    path_0.quadraticBezierTo(size.width*0.8978400,size.height*0.8543133,size.width*0.8973400,size.height*0.7850361);
    path_0.cubicTo(size.width*0.9111800,size.height*0.7459518,size.width*0.7659200,size.height*0.7141687,size.width*0.7532000,size.height*0.6318072);
    path_0.cubicTo(size.width*0.7614600,size.height*0.5537952,size.width*0.9043200,size.height*0.5412289,size.width*0.9006200,size.height*0.4896747);
    path_0.quadraticBezierTo(size.width*0.9003000,size.height*0.3614458,size.width*0.9020000,size.height*-0.0056024);
    path_0.lineTo(size.width*1.0039800,size.height*-0.0056024);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}



