import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardFormWidget extends StatefulWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  final String cardHolderNameValidationMessage;
  final String cardNumberValidationMessage;
  final String expiryDateValidationMessage;
  final String cvvValidationMessage;

  final void Function(CreditCardModel) onCreditCardModelChange;

  final InputDecoration cardHolderNameDecoration;
  final InputDecoration cardNumberDecoration;
  final InputDecoration expiryDateDecoration;
  final InputDecoration cvvDecoration;

  final GlobalKey<FormState> formKey;

  const CreditCardFormWidget({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvv,
    required this.onCreditCardModelChange,
    this.cardHolderNameDecoration = const InputDecoration(
      labelText: 'Card holder',
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'XXXX XXXX XXXX XXXX',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Expiry Date',
      hintText: 'MM/YY',
    ),
    this.cvvDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: 'XXX',
    ),
    this.cardHolderNameValidationMessage = 'Please input a valid holder name',
    this.cardNumberValidationMessage = 'Please input a valid number',
    this.expiryDateValidationMessage = 'Please input a valid date',
    this.cvvValidationMessage = 'Please input a valid CVV',
    required this.formKey,
  }) : super(key: key);

  @override
  _CreditCardFormWidgetState createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvv;
  bool isCvvFocused = false;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final FocusNode _cardHolderNameFocusNode = FocusNode();
  final FocusNode _cardNumberFocusNode = FocusNode();
  final FocusNode _expiryDateFocusNode = FocusNode();
  final FocusNode _cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = _cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvv = widget.cvv;

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvv, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    _cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvController.addListener(() {
      setState(() {
        cvv = _cvvController.text;
        creditCardModel.cvv = cvv;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            autofillHints: [AutofillHints.creditCardName],
            controller: _cardHolderNameController,
            decoration: widget.cardHolderNameDecoration,
            focusNode: _cardHolderNameFocusNode,
            keyboardType: TextInputType.name,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_cardNumberFocusNode);
            },
            textInputAction: TextInputAction.next,
            validator: (String? value) =>
                value!.isEmpty ? widget.cardHolderNameValidationMessage : null,
          ),
          SizedBox(height: Dimens.dp24.h),
          TextFormField(
              autofillHints: [AutofillHints.creditCardNumber],
              controller: _cardNumberController,
              decoration: widget.cardNumberDecoration,
              focusNode: _cardNumberFocusNode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter()
              ],
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_expiryDateFocusNode);
              },
              textInputAction: TextInputAction.next,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return widget.cardNumberValidationMessage;
                }
                value = CardUtils.getCleanedNumber(value);

                if (value.length < 8) {
                  return widget.cardNumberValidationMessage;
                }

                int sum = 0;
                int length = value.length;
                for (var i = 0; i < length; i++) {
                  // get digits in reverse order
                  int digit = int.parse(value[length - i - 1]);

                  // every 2nd number multiply with 2
                  if (i % 2 == 1) {
                    digit *= 2;
                  }
                  sum += digit > 9 ? (digit - 9) : digit;
                }

                if (sum % 10 == 0) {
                  return null;
                }

                return widget.cardNumberValidationMessage;
              }),
          SizedBox(height: Dimens.dp24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  autofillHints: [AutofillHints.creditCardExpirationDate],
                  controller: _expiryDateController,
                  decoration: widget.expiryDateDecoration,
                  focusNode: _expiryDateFocusNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_cvvFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return widget.expiryDateValidationMessage;
                    }

                    final DateTime now = DateTime.now();
                    final List<String> date = value.split(RegExp(r'/'));
                    final int month = int.parse(date.first);
                    final int year = int.parse('20${date.last}');
                    final DateTime cardDate = DateTime(year, month);

                    if (cardDate.isBefore(now) || month > 12 || month == 0) {
                      return widget.expiryDateValidationMessage;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: Dimens.dp24.w),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  decoration: widget.cvvDecoration,
                  focusNode: _cvvFocusNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 3) {
                      return widget.cvvValidationMessage;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _cardHolderNameFocusNode.dispose();
    _cardNumberFocusNode.dispose();
    _expiryDateFocusNode.dispose();
    _cvvFocusNode.dispose();
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardUtils {
  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
}
