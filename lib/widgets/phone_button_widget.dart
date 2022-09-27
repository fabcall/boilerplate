import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
    return GestureDetector(
      onTap: launchDialer,
      child: CircleAvatar(
        radius: 20.0,
        backgroundColor: Colors.green,
        child: Icon(
          Ionicons.call,
          color: Colors.white,
        ),
      ),
    );
  }

  void launchDialer() async {
    final urlDialer = "tel:$phoneNumber";
    final url = Uri.parse(urlDialer);
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $urlDialer';
  }
}
