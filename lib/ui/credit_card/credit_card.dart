import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/bottom_sheet_handle_widget.dart';
import 'package:boilerplate/widgets/credit_card.dart';
import 'package:boilerplate/widgets/credit_card_form_widget.dart';
import 'package:boilerplate/widgets/credit_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreditCardScreen extends StatefulWidget {
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  //state:----------------------------------------------------------------------
  bool showSecondChild = false;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Remover"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Excluir cartão"),
      content: Text("Tem certeza que deseja remover o cartão com final 5759?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - kToolbarHeight,
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        child: AnimatedCrossFade(
          crossFadeState: showSecondChild
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 400),
          firstChild: CreditCardList(showCreditCardForm: () {
            setState(() {
              showSecondChild = true;
            });
          }),
          secondChild: CreditCardForm(showCreditCardList: () {
            setState(() {
              showSecondChild = false;
            });
          }),
        ),
      ),
    );
  }
}

class CreditCardList extends StatefulWidget {
  final VoidCallback showCreditCardForm;

  const CreditCardList({Key? key, required this.showCreditCardForm})
      : super(key: key);

  @override
  _CreditCardListState createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {
  @override
  Widget build(BuildContext context) {
    final creditCards = <Widget>[];

    for (int i = 0; i < 5; i++) {
      creditCards
        ..add(Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            0,
            i < 4 ? 16.0 : 0,
            0,
          ),
          child: CreditCardWidget(
            cardHolderName: 'FABIO CALLIARI',
            cardNumber: '5502  ****  ****  5759',
            expiryDate: '',
            cvv: '',
            showBackView: false,
            height: 160.0,
            width: 240.0,
          ),
        ));
    }

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
          Center(
            child: Text(
              'Cartões de crédito',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: Dimens.dp24.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: creditCards),
              ),
            ],
          ),
          SizedBox(height: Dimens.dp24.h),
          ElevatedButton(
            onPressed: widget.showCreditCardForm,
            child: Text('Adicionar novo cartão'),
          ),
          SizedBox(height: Dimens.dp24.h),
        ],
      ),
    );
  }
}

class CreditCardForm extends StatefulWidget {
  final VoidCallback showCreditCardList;

  CreditCardForm({Key? key, required this.showCreditCardList})
      : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvv = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
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
            'Cartões de crédito',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: Dimens.dp24.h),
        Center(
          child: CreditCardWidget(
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cvv: cvv,
            showBackView: isCvvFocused,
          ),
        ),
        SizedBox(height: Dimens.dp24.h),
        CreditCardFormWidget(
          formKey: _formKey,
          onCreditCardModelChange: onCreditCardModelChange,
          cardHolderName: cardHolderName,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cvv: cvv,
          cardHolderNameDecoration: InputDecoration(
            labelText: 'labels_cardholder_name'.tr(),
            hintText: 'placeholders_cardholder_name'.tr(),
          ),
          cardNumberDecoration: InputDecoration(
            labelText: 'labels_card_number'.tr(),
            hintText: 'placeholders_card_number'.tr(),
          ),
          expiryDateDecoration: InputDecoration(
            labelText: 'labels_expiry_date'.tr(),
            hintText: 'placeholders_expiry_date'.tr(),
          ),
          cvvDecoration: InputDecoration(
            labelText: 'labels_cvv'.tr(),
            hintText: 'placeholders_cvv'.tr(),
          ),
        ),
        SizedBox(height: Dimens.dp18.h),
        ElevatedButton(
          onPressed: () {
            (_formKey.currentState)?.validate();
          },
          child: Text('Salvar novo cartão'),
        ),
        SizedBox(height: Dimens.dp4.h),
        OutlinedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            widget.showCreditCardList();
          },
          child: Text("Voltar"),
        ),
        SizedBox(height: Dimens.dp24.h),
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvv = creditCardModel.cvv;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
