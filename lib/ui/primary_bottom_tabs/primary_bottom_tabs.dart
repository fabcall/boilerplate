import 'dart:math' as math;
import 'package:boilerplate/ui/account/account.dart';
import 'package:boilerplate/ui/favorites/favorites.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/profile/profile.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/widgets/fab_bottom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PrimaryBottomTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrimaryBottomTabsState();
  }
}

class _PrimaryBottomTabsState extends State<PrimaryBottomTabs> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    HomeScreen(),
    AccountScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _openNewPage() {
    Navigator.of(context).pushNamed(Routes.qrCode);
  }

  static const double offset = 24.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Ionicons.qr_code,
          color: Colors.white,
        ),
        onPressed: _openNewPage,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
      ),
      floatingActionButtonLocation:
          const _CenterDockedFloatingActionButtonLocation(offset),
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Colors.white,
        color: Colors.grey,
        height: 64.0,
        iconGap: 8.0,
        iconSize: 20.0,
        notchedShape: CircularRaisedRectangle(),
        onTabSelected: (index) => _pageController.jumpToPage(index),
        selectedColor: Colors.black,
        items: [
          FABBottomAppBarItem(iconData: Ionicons.home_outline, label: "Home"),
          FABBottomAppBarItem(
              iconData: Ionicons.wallet_outline, label: "Conta"),
          FABBottomAppBarItem(
              iconData: Ionicons.heart_outline, label: "Favoritos"),
          FABBottomAppBarItem(
              iconData: Ionicons.person_outline, label: "Perfil"),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}

class CircularRaisedRectangle extends NotchedShape {
  const CircularRaisedRectangle();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.left, host.top)
      ..arcTo(
          Rect.fromLTWH(
            guest.left,
            guest.top,
            notchRadius * 2,
            notchRadius * 2,
          ),
          math.asin(1 - (host.top - guest.top) / notchRadius) + degToRad(180),
          math.acos(1 - (host.top - guest.top) / notchRadius) * 2,
          false)
      ..lineTo(guest.right, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

abstract class _DockedFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  const _DockedFloatingActionButtonLocation();

  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    // final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    // final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight / 2.0;
    // if (snackBarHeight > 0.0)
    //   fabY = math.min(
    //       fabY,
    //       contentBottom -
    //           snackBarHeight -
    //           fabHeight -
    //           kFloatingActionButtonMargin);
    // if (bottomSheetHeight > 0.0)
    //   fabY =
    //       math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return math.min(maxFabY, fabY);
  }
}

class _CenterDockedFloatingActionButtonLocation
    extends _DockedFloatingActionButtonLocation {
  const _CenterDockedFloatingActionButtonLocation(this.offset);

  final double offset;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;
    return Offset(fabX, getDockedY(scaffoldGeometry) + offset);
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}

num degToRad(num deg) => deg * (math.pi / 180.0);
