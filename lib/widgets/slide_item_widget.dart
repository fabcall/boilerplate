import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideItemWidget extends StatelessWidget {
  final String imageAssetPath;
  final String heading;
  final String subHeading;

  const SlideItemWidget({
    Key? key,
    required this.imageAssetPath,
    required this.heading,
    required this.subHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIllustration(context),
        SizedBox(height: 60.0.sp),
        _buildHeading(),
        Expanded(child: _buildSubHeading()),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return Container(
      child: SvgPicture.asset(imageAssetPath),
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dp20),
      child: Text(
        heading,
        style: TextStyle(
          fontFamily: FontFamily.comfortaa,
          fontWeight: FontWeight.w700,
          fontSize: 32.0.sp,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildSubHeading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dp20),
        child: Text(
          subHeading,
          style: TextStyle(
            fontFamily: FontFamily.productSans,
            fontWeight: FontWeight.normal,
            fontSize: 16.0.sp,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
