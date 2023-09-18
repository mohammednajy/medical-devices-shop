import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/modules/auth/controller/auth_controller.dart';
import 'package:medical_devices_app/modules/auth/view/auth_view.dart';
import 'package:medical_devices_app/modules/auth/view/checking_email_view.dart';
import 'package:medical_devices_app/modules/auth/view/login_view.dart';
import 'package:medical_devices_app/modules/auth/view/register_view.dart';
import 'package:medical_devices_app/modules/auth/view/reset_password.dart';
import 'package:medical_devices_app/modules/bnb/controller/bnb_controller.dart';
import 'package:medical_devices_app/modules/bnb/view/main_app_view.dart';
import 'package:medical_devices_app/modules/category/model/category_model.dart';
import 'package:medical_devices_app/modules/category/view/devices_details_view.dart';
import 'package:medical_devices_app/modules/category/view/devices_view.dart';
import 'package:medical_devices_app/modules/home/model/device_model.dart';
import 'package:medical_devices_app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:medical_devices_app/modules/onboarding/view/onboarding_view.dart';
import 'package:medical_devices_app/modules/order/view/cart_view.dart';
import 'package:medical_devices_app/modules/profile/view/FAQ_view.dart';
import 'package:medical_devices_app/modules/profile/view/about_app_view.dart';
import 'package:medical_devices_app/modules/profile/view/contactUs_view.dart';
import 'package:medical_devices_app/modules/profile/view/privicy_polices_view.dart';
import 'package:medical_devices_app/modules/profile/view/uses_policy_view.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.onboarding:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (context) => OnBoardingController(),
                child: const OnBoardingView()),
            settings: const RouteSettings(name: RouteName.onboarding));
      case RouteName.auth:
        return MaterialPageRoute(
            builder: (_) => const AuthView(),
            settings: const RouteSettings(name: RouteName.auth));
      case RouteName.register:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (context) => AuthController(),
                child: const RegisterView()),
            settings: const RouteSettings(name: RouteName.register));
      case RouteName.login:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<AuthController>(
                create: (context) => AuthController(),
                child: const LoginView()),
            settings: const RouteSettings(name: RouteName.login));
      case RouteName.forgetPassword:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (context) => AuthController(),
                child: const ResetPasswordView()),
            settings: const RouteSettings(name: RouteName.forgetPassword));
      case RouteName.checkEmail:
        return MaterialPageRoute(
            builder: (_) => const CheckingEmailView(),
            settings: const RouteSettings(name: RouteName.checkEmail));
      case RouteName.mainAppView:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (context) => BnbController(),
                child: const MainAppView()),
            settings: const RouteSettings(name: RouteName.mainAppView));

      case RouteName.devicesView:
        return MaterialPageRoute(
            builder: (_) => DeviceView(
                  category: settings.arguments as CategoryModel,
                ),
            settings: const RouteSettings(name: RouteName.devicesView));

      case RouteName.devicesDetailsView:
        return MaterialPageRoute(
            builder: (_) => DeviceDetailsView(
                  deviceModel: settings.arguments as DeviceModel,
                ),
            settings: const RouteSettings(name: RouteName.devicesDetailsView));

      case RouteName.cartView:
        return MaterialPageRoute(
            builder: (_) => const CartView(),
            settings: const RouteSettings(name: RouteName.cartView));

      case RouteName.contactUsView:
        return MaterialPageRoute(
            builder: (_) => const ContactUsView(),
            settings: const RouteSettings(name: RouteName.contactUsView));

      case RouteName.aboutAppView:
        return MaterialPageRoute(
            builder: (_) => const AboutAppView(),
            settings: const RouteSettings(name: RouteName.aboutAppView));

      case RouteName.privacyPoliceView:
        return MaterialPageRoute(
            builder: (_) => const PrivacyPolicesView(),
            settings: const RouteSettings(name: RouteName.privacyPoliceView));

      case RouteName.usesPoliceView:
        return MaterialPageRoute(
            builder: (_) => const UsesPolicyView(),
            settings: const RouteSettings(name: RouteName.usesPoliceView));

      case RouteName.faqView:
        return MaterialPageRoute(
            builder: (_) => const FAQView(),
            settings: const RouteSettings(name: RouteName.faqView));
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
