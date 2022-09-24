import 'package:boilerplate/ui/change_password/change_password.dart';
import 'package:boilerplate/ui/credit_card/credit_card.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/indication/indication.dart';
import 'package:boilerplate/ui/landing/landing.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/password_reset/password_reset.dart';
import 'package:boilerplate/ui/primary_bottom_tabs/primary_bottom_tabs.dart';
import 'package:boilerplate/ui/registration/registration.dart';
import 'package:boilerplate/ui/share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalBottomSheet extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const ModalBottomSheet(
      {Key? key, required this.child, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black12,
                              spreadRadius: 5)
                        ]),
                    width: double.infinity,
                    child: MediaQuery.removePadding(
                        context: context, removeTop: true, child: child)),
              ),
            ),
          ]),
    );
  }
}

class Routes {
  Routes._();

  //static variables
  static const String landing = '/landing';
  static const String login = '/login';
  static const String passwordReset = '/password_reset';
  static const String registration = '/registration';
  static const String primaryBottomTabs = '/primary_bottom_tabs';
  static const String changePassword = '/change_password';
  static const String creditCard = '/credit_card';
  static const String share = '/share';
  static const String indication = '/indication';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (context) {
          return LandingScreen();
        });
      case login:
        return _buildModalBottomSheet(child: Material(child: LoginScreen()));
      case passwordReset:
        return _buildModalBottomSheet(
            child: Material(child: PasswordResetScreen()));
      case registration:
        return _buildModalBottomSheet(
            child: Material(child: RegistrationScreen()));
      case primaryBottomTabs:
        return MaterialPageRoute(builder: (context) {
          return PrimaryBottomTabs();
        });
      case changePassword:
        return _buildModalBottomSheet(
            child: Material(child: ChangePasswordScreen()));
      case creditCard:
        return _buildModalBottomSheet(
            child: Material(child: CreditCardScreen()));
      case share:
        return _buildModalBottomSheet(child: Material(child: ShareScreen()));
      case indication:
        return _buildModalBottomSheet(
            child: Material(child: IndicationScreen()));
      default:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
    }
  }

  static ModalBottomSheetRoute<dynamic> _buildModalBottomSheet(
      {required Widget child}) {
    return ModalBottomSheetRoute(
      expanded: false,
      containerBuilder: (_, animation, child) => ModalBottomSheet(
        child: child,
        animation: animation,
      ),
      builder: (context) => child,
    );
  }
}
