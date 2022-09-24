import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/ui/password_reset/password_reset.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/widgets/bottom_sheet_handle_widget.dart';
import 'package:boilerplate/widgets/social_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //keys:-----------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();

  //text controllers:-----------------------------------------------------------
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        child: ListView(
          controller: ModalScrollController.of(context),
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'login_welcome_back',
                style: Theme.of(context).textTheme.headline6,
              ).tr(),
            ),
            SizedBox(height: Dimens.dp8.h),
            Center(
              child: Text(
                'login_enter_your_credentials',
                style: TextStyle(color: Colors.grey),
              ).tr(),
            ),
            SizedBox(height: Dimens.dp24.h),
            TextFormField(
              autofillHints: [AutofillHints.email],
              autofocus: true,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'labels_email'.tr(),
                hintText: 'placeholders_email'.tr(),
              ),
              focusNode: _emailFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: Dimens.dp24.h),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'labels_password'.tr(),
                hintText: 'placeholders_password'.tr(),
              ),
              focusNode: _passwordFocusNode,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: Dimens.dp18.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.passwordReset);
                },
                child: Text(
                  'login_forgot_your_password',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ).tr(),
              ),
            ),
            SizedBox(height: Dimens.dp8.h),
            ElevatedButton(
              onPressed: () {},
              child: Text('login_sign_in').tr(),
            ),
            SizedBox(height: Dimens.dp24.h),
            SocialWidget(),
            SizedBox(height: Dimens.dp24.h),
          ],
        ),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
