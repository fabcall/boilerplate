import 'package:boilerplate/constants/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();

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
                'password_reset_forgot_my_password',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ).tr(),
            ),
            SizedBox(height: Dimens.dp8.h),
            Center(
              child: Text(
                'password_reset_enter_your_email_and_we_will_send_you_a_link',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ).tr(),
            ),
            SizedBox(height: Dimens.dp24.h),
            TextFormField(
              autofillHints: [AutofillHints.email],
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'labels_email'.tr(),
                hintText: 'placeholders_email'.tr(),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: Dimens.dp24.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                    }
                  },
                  child: Text('password_reset_reset').tr(),
                ),
                SizedBox(height: Dimens.dp4.h),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('password_reset_back').tr(),
                ),
                SizedBox(height: Dimens.dp24.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
