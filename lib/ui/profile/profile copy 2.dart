import 'dart:math';

import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const avatarSize = 96.0;
const minAvatarSize = 30.0;
const extraSpace = 70.0;

class SettingModel {
  final String label;
  final IconData iconData;
  final VoidCallback? onTap;

  SettingModel(this.label, {required this.iconData, this.onTap});
}

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  late List<SettingModel> _settingsList = [];

  @override
  void initState() {
    super.initState();

    _settingsList = [
      SettingModel(
        'profile_tab_change_password'.tr(),
        iconData: MdiIcons.lockOutline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.changePassword);
        },
      ),
      SettingModel('profile_tab_payment_methods'.tr(),
          iconData: MdiIcons.creditCardOutline, onTap: () {
        Navigator.of(context).pushNamed(Routes.creditCard);
      }),
      SettingModel(
        'profile_tab_share_with_a_friend'.tr(),
        iconData: MdiIcons.accountGroupOutline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.share);
        },
      ),
      SettingModel(
        'profile_tab_suggest_establishment'.tr(),
        iconData: MdiIcons.beerOutline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.indication);
        },
      ),
      SettingModel(
        'profile_tab_coupons'.tr(),
        iconData: MdiIcons.tagOutline,
      ),
      SettingModel(
        'profile_tab_notifications'.tr(),
        iconData: MdiIcons.bellOutline,
      ),
      SettingModel(
        'profile_tab_help'.tr(),
        iconData: MdiIcons.helpCircleOutline,
      ),
      SettingModel(
        'profile_tab_sign_out'.tr(),
        iconData: MdiIcons.logout,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate:
                  MyHeaderDelegate(kToolbarHeight + avatarSize + extraSpace),
              pinned: true,
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.dp18.h),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              color: Colors.white,
            ),
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.dp8.w, vertical: Dimens.dp8.h),
                itemCount: _settingsList.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    horizontalTitleGap: 0,
                    dense: true,
                    onTap: () => _settingsList[i].onTap?.call(),
                    leading: Icon(
                      _settingsList[i].iconData,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(_settingsList[i].label),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.red,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          visible: i == 4,
                        ),
                        SizedBox(width: Dimens.dp8.w),
                        Icon(
                          MdiIcons.chevronRight,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider()),
          ),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;

  MyHeaderDelegate(this.extendedHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = avatarSize + extraSpace - shrinkOffset;
    double newAvatarSize = avatarSize - shrinkOffset;
    double newAvatarSpace = avatarSize - shrinkOffset;
    if (newSize < minExtent) {
      newSize = minExtent;
    }
    if (newAvatarSize < minAvatarSize) {
      newAvatarSize = minAvatarSize;
    }
    if (newAvatarSpace < 0) {
      newAvatarSpace = 0;
    }
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (avatarSize + extraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kToolbarHeight + newAvatarSpace,
            child: Stack(
              children: [
                AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  centerTitle: false,
                  elevation: newSize == minExtent ? 4.0 : 0.0,
                  title: Text(
                    'perfil',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontFamily: FontFamily.comfortaa,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: minAvatarSize / 2,
                  right: avatarXPosition,
                  child: Stack(
                    children: [
                      Container(
                        height: newAvatarSize,
                        width: newAvatarSize,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://randomuser.me/api/portraits/men/0.jpg'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          opacity: newSize < maxExtent ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            height: 24.0,
                            width: 24.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              MdiIcons.pencil,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: percent,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  child: Text("Bianca Silva Lima",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Expanded(
                  child: Text("Assinatura Premium"),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimens.dp12.h),
      ],
    );
  }
}
