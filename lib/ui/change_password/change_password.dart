import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/bottom_sheet_handle_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode _passwordFocusNode;
  late FocusNode _newPasswordFocusNode;
  late FocusNode _newPasswordConfirmationFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _newPasswordConfirmationFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
              'Alterar senha',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: Dimens.dp24.h),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'labels_old_password'.tr(),
              hintText: 'placeholders_old_password'.tr(),
            ),
            focusNode: _passwordFocusNode,
            obscureText: true,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(_newPasswordFocusNode);
            },
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: Dimens.dp24.h),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'labels_new_password'.tr(),
              hintText: 'placeholders_new_password'.tr(),
            ),
            focusNode: _newPasswordFocusNode,
            obscureText: true,
            onFieldSubmitted: (term) {
              FocusScope.of(context)
                  .requestFocus(_newPasswordConfirmationFocusNode);
            },
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: Dimens.dp24.h),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'labels_new_password_confirmation'.tr(),
              hintText: 'placeholders_new_password_confirmation'.tr(),
            ),
            focusNode: _newPasswordConfirmationFocusNode,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: Dimens.dp18.h),
          ElevatedButton(
            onPressed: () {},
            child: Text('Salvar senha'),
          ),
          SizedBox(height: Dimens.dp24.h),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _passwordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _newPasswordConfirmationFocusNode.dispose();
    super.dispose();
  }
}
