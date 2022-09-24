import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/bottom_sheet_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_share/social_share.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Indique para um amigo',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: Dimens.dp24),
          SvgPicture.asset(
            Assets.messageSentIllustration,
            height: 159.0.h,
          ),
          const SizedBox(height: Dimens.dp24),
          ListView(
            padding: const EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                horizontalTitleGap: 0,
                dense: true,
                leading: SvgPicture.asset(
                  Assets.icWhatsApp,
                  color: Color.fromRGBO(37, 211, 102, 1),
                ),
                title: Text('Amigos do WhatsApp'),
                trailing: Icon(
                  MdiIcons.chevronRight,
                  color: Colors.black,
                ),
                onTap: () {
                  SocialShare.shareWhatsapp("content");
                },
              ),
              Divider(),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                horizontalTitleGap: 0,
                dense: true,
                leading: SvgPicture.asset(
                  Assets.icFacebook,
                  color: Color.fromRGBO(24, 119, 242, 1),
                ),
                title: Text('Amigos do Facebook'),
                trailing: Icon(
                  MdiIcons.chevronRight,
                  color: Colors.black,
                ),
              ),
              Divider(),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                horizontalTitleGap: 0,
                dense: true,
                leading: SvgPicture.asset(
                  Assets.icMessenger,
                  color: Color.fromRGBO(0, 178, 255, 1),
                ),
                title: Text('Amigos do Messenger'),
                trailing: Icon(
                  MdiIcons.chevronRight,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: Dimens.dp24.h)
            ],
          ),
        ],
      ),
    );
  }
}
