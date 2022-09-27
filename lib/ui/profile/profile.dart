import 'dart:math';

import 'package:badges/badges.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

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

class ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  late List<SettingModel> _settingsList = [];

  @override
  void initState() {
    super.initState();

    _settingsList = [
      SettingModel(
        'profile_tab_change_password'.tr(),
        iconData: Ionicons.lock_closed_outline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.changePassword);
        },
      ),
      SettingModel('profile_tab_payment_methods'.tr(),
          iconData: Ionicons.card_outline, onTap: () {
        Navigator.of(context).pushNamed(Routes.creditCard);
      }),
      SettingModel(
        'profile_tab_share_with_a_friend'.tr(),
        iconData: Ionicons.people_outline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.share);
        },
      ),
      SettingModel(
        'profile_tab_suggest_establishment'.tr(),
        iconData: Ionicons.beer_outline,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.indication);
        },
      ),
      SettingModel(
        'profile_tab_coupons'.tr(),
        iconData: Ionicons.pricetag_outline,
      ),
      SettingModel(
        'profile_tab_notifications'.tr(),
        iconData: Ionicons.notifications_outline,
      ),
      SettingModel(
        'profile_tab_help'.tr(),
        iconData: Ionicons.help_circle_outline,
      ),
      SettingModel(
        'profile_tab_sign_out'.tr(),
        iconData: Ionicons.log_out_outline,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: NestedScrollView(
        physics: SnapScrollPhysics(snaps: [
          Snap.avoidZone(0, avatarSize + extraSpace),
        ]),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate:
                  MyHeaderDelegate(kToolbarHeight + avatarSize + extraSpace),
              pinned: true,
            ),
          ];
        },
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.dp8.w, vertical: Dimens.dp8.h),
          itemCount: _settingsList.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
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
                    child: Badge(
                      elevation: 0,
                      shape: BadgeShape.circle,
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    visible: i == 4,
                  ),
                  SizedBox(width: Dimens.dp8.w),
                  Icon(
                    Ionicons.chevron_forward_outline,
                    color: Colors.black,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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

    return Column(
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
                      child: AnimatedScale(
                        scale: newSize < maxExtent ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Ionicons.pencil_outline,
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
