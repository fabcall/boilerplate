import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/social_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
//text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordConfirmationFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmationFocusNode = FocusNode();
  }

  //state:----------------------------------------------------------------------
  bool _showSecondChild = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - kToolbarHeight,
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      child: Flexible(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          child: AnimatedCrossFade(
            crossFadeState: _showSecondChild
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 400),
            firstChild: _buildFirstChild(),
            secondChild: _buildSecondChild(),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstChild() {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showSecondChild = true;
                FocusScope.of(context).requestFocus(_nameFocusNode);
              });
            },
            child: Text('registration_register_using_email').tr(),
          ),
          SizedBox(height: Dimens.dp24.h),
          SocialWidget(),
          SizedBox(height: Dimens.dp24.h),
        ],
      ),
    );
  }

  Widget _buildSecondChild() {
    return ListView(
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
            'registration_register_new_account',
            style: Theme.of(context).textTheme.headline6,
          ).tr(),
        ),
        _buildSpacer(),
        _buildNameField(),
        _buildSpacer(),
        _buildEmailField(),
        _buildSpacer(),
        _buildPasswordField(),
        _buildSpacer(),
        _buildPasswordConfirmationField(),
        _buildSpacer(),
        _buildSignUpButton(),
        SizedBox(height: Dimens.dp4.h),
        OutlinedButton(
          onPressed: () {
            setState(() {
              FocusScope.of(context).unfocus();
              _showSecondChild = false;
            });
          },
          child: Text('registration_back').tr(),
        ),
        _buildSpacer(),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      autofillHints: [AutofillHints.name],
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'labels_name'.tr(),
        hintText: 'placeholders_name'.tr(),
      ),
      focusNode: _nameFocusNode,
      keyboardType: TextInputType.name,
      onChanged: (value) {},
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      autofillHints: [AutofillHints.email],
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'labels_email'.tr(),
        hintText: 'placeholders_email'.tr(),
      ),
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {},
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'labels_password'.tr(),
        hintText: 'placeholders_password'.tr(),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.visibility,
          ),
          onPressed: () {},
        ),
      ),
      focusNode: _passwordFocusNode,
      obscureText: true,
      onChanged: (value) {},
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordConfirmationFocusNode);
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordConfirmationField() {
    return TextFormField(
      controller: _passwordConfirmationController,
      decoration: InputDecoration(
        labelText: 'labels_password_confirmation'.tr(),
        hintText: 'placeholders_password_confirmation'.tr(),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.visibility,
          ),
          onPressed: () {},
        ),
      ),
      focusNode: _passwordConfirmationFocusNode,
      obscureText: true,
      onChanged: (value) {},
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'registration_register',
      ).tr(),
    );
  }

  Widget _buildSpacer() => SizedBox(height: Dimens.dp24.h);

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    super.dispose();
  }
}
