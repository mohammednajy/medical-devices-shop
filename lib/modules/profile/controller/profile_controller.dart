import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';
import 'package:medical_devices_app/modules/profile/model/about_app_model.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/local_services/shared_perf.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends ChangeNotifier {
  FirebaseResponse<List<AboutAppModel>> aboutApp = FirebaseResponse.init();
  FirebaseResponse<List<AboutAppModel>> privacyPolices =
      FirebaseResponse.init();

  logOut() async {
    await getIt<FirebaseService>().auth.signOut();
    SharedPrefController().isLoggedIn(value: false);
    SharedPrefController().remove();
    NavigationManager.goToAndRemove(RouteName.login);
  }

  whatsappSupport() async {
    const url = "whatsapp://send?phone=+972592663280";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint('whatsapp error');
    }
  }

  emailSupport() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      queryParameters: <String, String>{
        'subject': 'Support',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    } else {
      debugPrint('whatsapp error');
    }
  }

  callSupport() async {
    try {
      Uri email = Uri(
        scheme: 'tel',
        path: "+972592663280",
      );
      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  aboutTheApp() async {
    aboutApp = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>()
        .firestore
        .collection('aboutApp')
        .doc('HwGwArfS5nmrWXdgx19n')
        .get()
        .then((value) {
      List response = value.data()!['about'];
      aboutApp = FirebaseResponse.completed(
          response.map((e) => AboutAppModel.fromJson(e)).toList());
      notifyListeners();
    }).catchError((e) {
      aboutApp = FirebaseResponse.error('error');
      notifyListeners();
    });
  }

  privacyPolice() async {
    privacyPolices = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>()
        .firestore
        .collection('aboutApp')
        .doc('SHbDekFsJpMYbYrfhDcm')
        .get()
        .then((value) {
      List response = value.data()!['privacy '];
      privacyPolices = FirebaseResponse.completed(
          response.map((e) => AboutAppModel.fromJson(e)).toList());
      notifyListeners();
    }).catchError((e) {
      print(e);
      privacyPolices = FirebaseResponse.error('error');
      notifyListeners();
    });
  }
}
