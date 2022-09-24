import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/components/service_locator.dart';
import 'package:boilerplate/stores/settings/settings_store.dart';
import 'package:boilerplate/ui/landing/landing.dart';
import 'package:boilerplate/ui/onboarding/onboarding.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final SettingsStore _settingsStore = SettingsStore(getIt<Repository>());
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SettingsStore>(create: (_) => _settingsStore),
        Provider<ThemeStore>(create: (_) => _themeStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return ScreenUtilInit(
            designSize: Size(360, 752),
            builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: _themeStore.darkMode ? themeDataDark : themeData,
              onGenerateRoute: (settings) => Routes.generateRoute(settings),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: _settingsStore.userDidFinishOnboarding
                  ? LandingScreen()
                  : OnboardingScreen(),
            ),
          );
        },
      ),
    );
  }
}
