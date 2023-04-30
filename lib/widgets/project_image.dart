import 'package:flutter/material.dart';

class PortfolioImage extends StatelessWidget {
  final String image;
  const PortfolioImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(image))),
    );
  }
}
