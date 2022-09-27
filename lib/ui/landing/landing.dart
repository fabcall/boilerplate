import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    final tween = MovieTween()
      ..tween(
        "opacity",
        Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300),
      )
      ..tween(
        "y",
        Tween(begin: 10.0, end: 0.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

    return Builder(
      builder: (context) => Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dp36.h,
              vertical: Dimens.dp12.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAppLogo(),
                PlayAnimationBuilder<Movie>(
                  tween: tween,
                  delay: Duration(seconds: 2),
                  duration: tween.duration,
                  builder: (context, value, _) {
                    return Opacity(
                      opacity: value.get('opacity'),
                      child: Transform.translate(
                        offset: Offset(0, value.get('y')),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSignInButton(context),
                            _buildSpacer(),
                            _buildSignUpButton(context),
                            _buildSpacer(),
                            _buildNavigateToHome(context),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Expanded(
      child: Center(
        child: PlayAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          delay: const Duration(seconds: 1),
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          builder: (context, value, _) => Transform.scale(
            child: SvgPicture.asset(
              Assets.appLogo,
              semanticsLabel: 'Barpass',
              height: 56.0,
            ),
            scale: value,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.login);
      },
      child: Text('landing_sign_in').tr(),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.registration);
      },
      child: Text('landing_sign_up').tr(),
    );
  }

  Widget _buildNavigateToHome(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Routes.primaryBottomTabs);
      },
      child: Text('landing_enter_as_a_guest').tr(),
    );
  }

  Widget _buildSpacer() => SizedBox(height: Dimens.dp8.h);
}
