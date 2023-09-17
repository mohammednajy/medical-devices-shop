import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';
import 'package:medical_devices_app/core/widgets/show_snackbar.dart';
import 'package:medical_devices_app/modules/order/model/cart_model.dart';

import '../../../core/services/local_services/shared_perf.dart';

class OrderController extends ChangeNotifier {
  FirebaseResponse<List<CartModel>> cart = FirebaseResponse.init();

  getCartDevices() async {
    try {
      cart = FirebaseResponse.loading('loading');
      notifyListeners();
      final snapshot = await getIt<FirebaseService>()
          .firestore
          .collection('cart')
          .where('userID', isEqualTo: SharedPrefController().getUser().userId)
          .get();
      cart = FirebaseResponse.completed(snapshot.docs.map((element) {
        return CartModel.fromSnapshot(element);
      }).toList());
      notifyListeners();
    } on Exception {
      cart = FirebaseResponse.error('something went wrong');
      notifyListeners();
    }
  }

  deleteOrder(String id) async {
    await getIt<FirebaseService>()
        .firestore
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) {
      getCartDevices();
      showSnackBarCustom(text: 'تم الحذف بنجاح');
    }).onError((error, stackTrace) => showSnackBarCustom(text: 'لم يتم الحذف'));
  }
}
