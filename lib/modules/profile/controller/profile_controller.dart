import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/local_services/shared_perf.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends ChangeNotifier {
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
}
