import 'package:flutter/material.dart';
import 'package:responsive_assignment/constants/size_constants.dart';
import 'package:responsive_assignment/extensions/size_extenstions.dart';
import 'package:responsive_assignment/screenutils/screen_util.dart';

class SocialWidget extends StatelessWidget {
  final Color backgroundColor;
  final bool isMobile;
  final Widget icon;

  const SocialWidget({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: isMobile
            ? ScreenUtil.screenHeight * .018
            : ScreenUtil.screenHeight * .03,
        backgroundColor: backgroundColor,
        child: icon);
  }
}
