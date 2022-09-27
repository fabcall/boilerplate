import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FallBackAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final String initials;
  final TextStyle? textStyle;
  final Color circleBackground;
  final double radius;

  const FallBackAvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.initials,
    this.textStyle,
    required this.circleBackground,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => new CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
        backgroundColor: circleBackground,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        backgroundColor: circleBackground,
        radius: radius,
        child: Text(
          initials,
          style: textStyle?.copyWith(
            color: Colors.black38,
            fontSize: radius,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        child: Center(child: CircularProgressIndicator()),
        width: radius * 2,
        height: radius * 2,
      ),
    );
  }
}
