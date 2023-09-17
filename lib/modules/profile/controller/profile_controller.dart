import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/local_services/shared_perf.dart';

class ProfileController extends ChangeNotifier {
  logOut() async {
    await getIt<FirebaseService>().auth.signOut();
    SharedPrefController().isLoggedIn(value: false);
    SharedPrefController().remove();
    NavigationManager.goToAndRemove(RouteName.login);
  }
}
