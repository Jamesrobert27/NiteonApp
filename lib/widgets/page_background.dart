// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageBackground extends StatelessWidget {
  PageBackground(
      {required this.background,
      required this.body,
      this.blendColors,
      this.begin,
      Key? key})
      : super(key: key);
  String background;
  Widget body;
  List<Color>? blendColors;
  AlignmentGeometry? begin;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 8,
                child: ShaderMask(
                  shaderCallback: (mask) => LinearGradient(
                          colors: blendColors ??
                              [
                                Colors.black12,
                                Colors.black,
                              ],
                          begin: begin ?? Alignment.center,
                          end: Alignment.bottomCenter)
                      .createShader(mask),
                  blendMode: BlendMode.darken,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(background), fit: BoxFit.cover)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox.shrink(),
              )
            ],
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: body,
          )
        ],
      ),
    );
  }
}
