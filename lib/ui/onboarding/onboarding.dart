import 'dart:math';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/models/slide/slide.dart';
import 'package:boilerplate/stores/settings/settings_store.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/widgets/slide_dots_widget.dart';
import 'package:boilerplate/widgets/slide_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //stores:---------------------------------------------------------------------
  late SettingsStore _settingsStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _settingsStore = Provider.of<SettingsStore>(context);
  }

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final List<Slide> _slides = [
    Slide(
      imageAssetPath: Assets.havingFunIllustration,
      heading: 'onboarding_meet_barpass'.tr(),
      subHeading: 'onboarding_an_app_for_you_to_save_for_real'.tr(),
    ),
    Slide(
      imageAssetPath: Assets.mobileFeedIllustration,
      heading: 'onboarding_barpass_discount'.tr(),
      subHeading: 'onboarding_discounts_at_your_favorite_establishment'.tr(),
    ),
    Slide(
      imageAssetPath: Assets.mobilePayIllustration,
      heading: 'onboarding_pay_your_bill_with_barpass'.tr(),
      subHeading: 'onboarding_read_the_qr_code_and_pay_your_bill'.tr(),
    )
  ];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _previousPage() {
    _pageController.animateToPage(
      _currentPage - 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  void _nextPage() {
    _pageController.animateToPage(
      _currentPage + 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  void _skipOnboarding() {
    _settingsStore.setUserDidFinishOnboarding(true);
    Navigator.of(context).pushReplacementNamed(Routes.landing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _renderBody());
  }

  Widget _renderBody() {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  child: Text('Pular'),
                  onPressed: () => _skipOnboarding(),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _slides.length,
                itemBuilder: (ctx, i) => SlideItemWidget(
                  heading: _slides[i].heading,
                  imageAssetPath: _slides[i].imageAssetPath,
                  subHeading: _slides[i].subHeading,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  AnimatedSlide(
                    offset: Offset.fromDirection(
                      0.5 * pi,
                      _currentPage == _slides.length - 1 ? 0 : 1,
                    ),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          child: Text('Vamos lá'),
                          onPressed: () => _skipOnboarding(),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSlide(
                    offset: Offset.fromDirection(
                      0,
                      _currentPage == _slides.length - 1 ? 1 : 0,
                    ),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          child: Text('Próximo'),
                          onPressed: () => _nextPage(),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSlide(
                    offset: Offset.fromDirection(
                      0,
                      _currentPage > 0 ? 0 : -1,
                    ),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                          child: Text('Anterior'),
                          onPressed: () => _previousPage(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    margin: EdgeInsets.only(bottom: Dimens.dp20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < _slides.length; i++)
                          if (i == _currentPage)
                            SlideDotsWidget(isActive: true)
                          else
                            SlideDotsWidget(isActive: false)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
