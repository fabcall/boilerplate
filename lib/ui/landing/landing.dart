import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/ui/registration/registration.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
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
                _buildSignInButton(context),
                _buildSpacer(),
                _buildSignUpButton(context),
                _buildSpacer(),
                _buildNavigateToHome(context),
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
        child: SvgPicture.asset(
          Assets.appLogo,
          semanticsLabel: 'Barpass',
          height: 56.0,
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
