import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/widgets/social_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  //keys:-----------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();

  //text controllers:-----------------------------------------------------------
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _valueFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _valueFocusNode = FocusNode();
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
                'Pague sua conta agora',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: Dimens.dp24.h),
            Center(
              child: Text(
                'Insira o valor da sua conta',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: Dimens.dp8.h),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'R\$ 0,00',
              ),
              focusNode: _valueFocusNode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                // Fit the validating format.
                //fazer o formater para x dinheiro
                CurrencyTextInputFormatter()
              ],
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: Dimens.dp18.h),
            ElevatedButton(
              onPressed: () {},
              child: Text('Pagar direto no caixa'),
            ),
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
    _valueFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
