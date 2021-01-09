// Created by AMIT JANGID on 09/01/21.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class ImageFromNetwork extends StatelessWidget {
  final String imageUrl;
  final double borderRadius, imageWidth, imageHeight;

  ImageFromNetwork({
    this.imageWidth,
    this.imageHeight,
    this.borderRadius = 100,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(width: 2, color: kPrimaryColor),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: imageWidth,
          imageUrl: imageUrl,
          height: imageHeight,
          errorWidget: (BuildContext context, String url, error) {
            return Image(width: imageWidth, height: imageHeight, image: AssetImage(kIconPerson));
          },
          placeholder: (BuildContext context, String url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Container(width: imageWidth, height: imageHeight, color: Colors.grey[300]),
            );
          },
        ),
      ),
    );
  }
}
