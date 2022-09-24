import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardModel {
  CreditCardModel(
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvv,
    this.isCvvFocused,
  );

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvv = '';
  bool isCvvFocused = false;
}

enum CardType {
  Master,
  Visa,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid,
}

const Map<CardType, String> CardTypeIconAsset = <CardType, String>{
  CardType.Master: 'assets/images/mastercard.svg',
  CardType.Visa: 'assets/images/visa.svg',
  CardType.Discover: 'assets/images/discover.svg',
  CardType.AmericanExpress: 'assets/images/americanexpress.svg',
  CardType.DinersClub: 'assets/images/dinersclub.svg',
  CardType.Jcb: 'assets/images/jcb.svg'
};

CardType getCardTypeFrmNumber(String input) {
  CardType cardType;
  if (input.startsWith(new RegExp(
      r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
    cardType = CardType.Master;
  } else if (input.startsWith(new RegExp(r'[4]'))) {
    cardType = CardType.Visa;
  } else if (input.startsWith(new RegExp(r'((34)|(37))'))) {
    cardType = CardType.AmericanExpress;
  } else if (input.startsWith(new RegExp(r'((6[45])|(6011))'))) {
    cardType = CardType.Discover;
  } else if (input.startsWith(new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
    cardType = CardType.DinersClub;
  } else if (input.startsWith(new RegExp(r'(352[89]|35[3-8][0-9])'))) {
    cardType = CardType.Jcb;
  } else if (input.length <= 8) {
    cardType = CardType.Others;
  } else {
    cardType = CardType.Invalid;
  }
  return cardType;
}

Widget getCardTypeImage(CardType? cardType) => SvgPicture.asset(
      CardTypeIconAsset[cardType]!,
      height: 36.0,
      width: 36.0,
    );

Widget getCardTypeIcon(String cardNumber) {
  CardType cardType = getCardTypeFrmNumber(cardNumber);
  Widget widget = Container(
    height: 36.0,
    width: 36.0,
  );

  if (CardTypeIconAsset.containsKey(cardType)) {
    widget = getCardTypeImage(cardType);
  }

  return widget;
}
