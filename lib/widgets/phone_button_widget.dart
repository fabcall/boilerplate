import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneButtonWidget extends StatelessWidget {
  final String phoneNumber;

  const PhoneButtonWidget({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 50),
      child: MaterialButton(
        color: Colors.green,
        padding: EdgeInsets.symmetric(
          vertical: 12,
        ),
        shape: StadiumBorder(),
        child: Icon(MdiIcons.phone, color: Colors.white),
        onPressed: launchDialer,
      ),
    );
  }

  void launchDialer() async {
    final urlDialer = "tel:$phoneNumber";
    await canLaunch(urlDialer)
        ? await launch(urlDialer)
        : throw 'Could not launch $urlDialer';
  }
}
