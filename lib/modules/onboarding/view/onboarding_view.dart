import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import 'package:medical_devices_app/core/utils/constant.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:medical_devices_app/modules/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingView> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    print(height / 8);
    return Scaffold(
        body: Consumer<OnBoardingController>(
      builder: (context, onboardingProvider, child) => ListView(
        children: [
          SizedBox(
            height: height / 14,
          ),
          SizedBox(
            height: height / 2.7,
            child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  onboardingProvider.changeIndex(value);
                },
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Image.asset(
                      onboardingContent[onboardingProvider.selectedIndex].image,
                    )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 16,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 14,
                ),
                Text(
                  onboardingContent[onboardingProvider.selectedIndex].title,
                  textAlign: TextAlign.center,
                  style: context.h1,
                ),
                SizedBox(
                  height: height / 12,
                  child: Text(
                    onboardingContent[onboardingProvider.selectedIndex]
                        .description,
                    textAlign: TextAlign.center,
                    style: context.b1.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: height / 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (onboardingProvider.selectedIndex == 2) {
                      NavigationManager.goToAndRemove(RouteName.auth);
                      SharedPrefController().setOnBoarding(value: true);
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Text(onboardingProvider.selectedIndex == 2
                      ? 'انشاء حساب'
                      : 'التالي'),
                ),
                
              ],
            ),
          )
        ],
      ),
    ));
  }
}
