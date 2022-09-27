import 'package:boilerplate/widgets/credit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

int sumChars(String str) {
  final charcodes = str.codeUnits;
  int sum = 0;
  for (var i = 0; i < charcodes.length; i++) {
    sum += charcodes[i];
  }
  return sum;
}

Color generateBackgroundColor(String str, List<Color> defaultColors) {
  final i = sumChars(str) % defaultColors.length;
  return defaultColors[i];
}

class CreditCardWidget extends StatefulWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final bool showBackView;
  final double? height;
  final double? width;
  final Color cardColor;

  final String labelCardHolder;
  final String labelExpiryDate;

  CreditCardWidget({
    Key? key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.showBackView,
    this.height,
    this.width,
    this.cardColor = const Color(0xff1b447b),
    this.labelCardHolder = 'CARD HOLDER',
    this.labelExpiryDate = 'MM/YY',
  }) : super(key: key);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final FlipCardController _controller = new FlipCardController();

  late Gradient backgroundGradientColor;

  @override
  void initState() {
    super.initState();

    _gradientSetup();
  }

  void _gradientSetup() {
    backgroundGradientColor = LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const <double>[0.1, 0.4, 0.7, 0.9],
      colors: <Color>[
        widget.cardColor.withOpacity(1),
        widget.cardColor.withOpacity(0.97),
        widget.cardColor.withOpacity(0.90),
        widget.cardColor.withOpacity(0.86),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    if (_controller.state != null &&
        ((widget.showBackView && _controller.state!.isFront) ||
            (!widget.showBackView && !_controller.state!.isFront))) {
      _controller.toggleCard();
    }

    return FlipCard(
      controller: _controller,
      flipOnTouch: false,
      front: buildCardFront(width, height, context, orientation),
      back: buildCardBack(width, height, context, orientation),
    );
  }

  Widget buildCardFront(double width, double height, BuildContext context,
      Orientation orientation) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: backgroundGradientColor,
      ),
      height: widget.height ??
          (orientation == Orientation.portrait ? height / 4 : height / 2),
      width: widget.width ?? width,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/credit_card_chip.svg',
                  height: 36.0,
                  width: 36.0,
                ),
                getCardTypeIcon(widget.cardNumber),
              ],
            ),
            Text(
              widget.cardNumber.isNotEmpty
                  ? widget.cardNumber
                  : '0000  0000  0000  0000',
              style: TextStyle(
                color: widget.cardNumber.isNotEmpty
                    ? Colors.white
                    : Colors.white.withAlpha(100),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.cardHolderName.isNotEmpty
                        ? widget.cardHolderName
                        : widget.labelCardHolder,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: widget.cardHolderName.isNotEmpty
                              ? Colors.white
                              : Colors.white.withAlpha(100),
                        ),
                  ),
                ),
                Text(
                  widget.expiryDate.isNotEmpty
                      ? widget.expiryDate
                      : widget.labelExpiryDate,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: widget.expiryDate.isNotEmpty
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCardBack(double width, double height, BuildContext context,
      Orientation orientation) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: backgroundGradientColor,
        ),
        height: widget.height ??
            (orientation == Orientation.portrait ? height / 4 : height / 2),
        width: widget.width ?? width,
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              Container(
                height: 40,
                color: Colors.grey[700],
              ),
              Padding(
                child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  child: Text(
                    widget.cvv.isNotEmpty ? widget.cvv : '000',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: widget.cvv.isNotEmpty
                              ? Colors.black
                              : Colors.black.withAlpha(100),
                        ),
                  ),
                  height: 20,
                  width: double.infinity,
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            ],
          ),
        ));
  }
}
