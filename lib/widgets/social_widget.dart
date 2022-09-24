import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.dp8.w,
              ),
              child: Text('Ou você pode fazer login via'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: Dimens.dp24.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      Assets.icFacebook,
                      height: 18.0,
                      color: Color.fromRGBO(24, 119, 242, 1),
                    ),
                    Text(
                      'Facebook',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(width: Dimens.dp8.w),
            Expanded(
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      Assets.icGoogle,
                      height: 18.0,
                      color: Color.fromRGBO(219, 68, 55, 1),
                    ),
                    Text(
                      'Google',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(width: Dimens.dp8.w),
            Expanded(
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      Assets.icApple,
                      height: 18.0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    Text(
                      'Apple',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ],
    );
  }
}
