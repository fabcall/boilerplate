import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/widgets/fallback_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EstablishmentListItem extends StatelessWidget {
  final String userAvatarUrl;
  final String tradeName;
  final String address;
  final String rating;
  final String distance;
  final bool barpassPay;
  final VoidCallback onTap;

  const EstablishmentListItem({
    Key? key,
    required this.userAvatarUrl,
    required this.tradeName,
    required this.address,
    required this.rating,
    required this.distance,
    required this.barpassPay,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            child: Row(
              children: <Widget>[
                FallBackAvatarWidget(
                  imageUrl: userAvatarUrl,
                  initials: "FA",
                  textStyle: TextStyle(),
                  circleBackground: Colors.grey.shade400,
                  radius: 32.0,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: _EstablishmentDescription(
                      address: address,
                      barpassPay: barpassPay,
                      distance: distance,
                      rating: rating,
                      tradeName: tradeName,
                    ),
                  ),
                ),
                Chip(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  label: Text(
                    '10%',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 20.0,
        ),
      ],
    );
  }
}

class _EstablishmentDescription extends StatelessWidget {
  final String tradeName;
  final String address;
  final String rating;
  final String distance;
  final bool barpassPay;

  const _EstablishmentDescription({
    Key? key,
    required this.tradeName,
    required this.address,
    required this.rating,
    required this.distance,
    required this.barpassPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tradeName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2.0),
        Text(
          address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 2.0),
        Row(
          children: <Widget>[
            _ItemWidget(
              iconColor: Colors.yellow.shade700,
              iconData: Ionicons.star,
              title: rating,
            ),
            SizedBox(width: 8.0),
            _ItemWidget(
              iconColor: Theme.of(context).colorScheme.primary,
              iconData: Ionicons.location,
              title: distance,
            ),
            SizedBox(width: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                SvgPicture.asset(Assets.icLogo, height: 16.0, width: 16.0),
                SizedBox(width: 4.0),
                Text(
                  'pay',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;
  final String title;

  const _ItemWidget({
    Key? key,
    required this.iconColor,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 16.0,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
