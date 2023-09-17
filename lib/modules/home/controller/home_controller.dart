import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_devices_app/modules/home/model/device_model.dart';

import '../../../core/services/remote_services/base_model.dart';
import '../../../core/services/remote_services/firebase_init.dart';

class HomeController extends ChangeNotifier {
  FirebaseResponse<List<DeviceModel>> lastAddedDevices =
      FirebaseResponse.init();
  FirebaseResponse<List<DeviceModel>> mostOrderedDevices =
      FirebaseResponse.init();
  Future<FirebaseResponse> getLastAddedDevices() async {
    lastAddedDevices = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>().firestore.collection('lastAdded').get().then(
      (QuerySnapshot value) {
        lastAddedDevices = FirebaseResponse.completed(value.docs.map((element) {
          return DeviceModel.fromSnapshot(element);
        }).toList());
        notifyListeners();
      },
    ).onError((error, stackTrace) {
      lastAddedDevices = FirebaseResponse.error(error.toString());
      notifyListeners();
    }).catchError((e) {
      lastAddedDevices = FirebaseResponse.error(e.toString());
      notifyListeners();
    });
    return lastAddedDevices;
  }

  Future<FirebaseResponse> getMostOrderedDevices() async {
    mostOrderedDevices = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>().firestore.collection('mostOrdered').get().then(
      (QuerySnapshot value) {
        mostOrderedDevices = FirebaseResponse.completed(value.docs.map((element) {
          return DeviceModel.fromSnapshot(element);
        }).toList());
        notifyListeners();
      },
    ).onError((error, stackTrace) {
      mostOrderedDevices = FirebaseResponse.error(error.toString());
      notifyListeners();
    }).catchError((e) {
      mostOrderedDevices = FirebaseResponse.error(e.toString());
      notifyListeners();
    });
    return mostOrderedDevices;
  }
}
