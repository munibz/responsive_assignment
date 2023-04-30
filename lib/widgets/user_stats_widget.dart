import 'package:flutter/material.dart';
import 'package:responsive_assignment/extensions/size_extenstions.dart';

import '../constants/size_constants.dart';

class UserStatWidget extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final bool isMobile;
  final String subtitle;
  const UserStatWidget({
    Key? key,
    required this.color,
    required this.textColor,
    required this.title,
    required this.subtitle,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: color),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: isMobile ? Sizes.dimen_24.sp : Sizes.dimen_20.sp,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: textColor,
            fontSize: isMobile ? Sizes.dimen_12.sp : Sizes.dimen_6.sp,
          ),
        ),
      ]),
    );
  }
}
