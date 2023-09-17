import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import 'package:medical_devices_app/core/widgets/loading_widget.dart';
import 'package:medical_devices_app/core/widgets/show_snackbar.dart';
import 'package:medical_devices_app/modules/auth/models/user_model.dart';

import '../../../core/services/remote_services/firebase_init.dart';

class AuthController extends ChangeNotifier {
  register(UserModel user) async {
    loadingWithText();
    try {
      UserCredential credential =
          await getIt<FirebaseService>().auth.createUserWithEmailAndPassword(
                email: user.email,
                password: user.password,
              );
      if (credential.user != null) {
        createUser(user);
        NavigationManager.goToAndRemove(RouteName.login);
      }
    } on FirebaseException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  login({
    required String email,
    required String password,
  }) async {
    loadingWithText();
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        NavigationManager.goToAndRemove(RouteName.mainAppView);
        SharedPrefController().isLoggedIn(value: true);
        saveUser(email: email, password: password);
        showSnackBarCustom(
          text: 'logged in successfully',
          backgroundColor: Colors.green,
        );
      }
    } on FirebaseException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  createUser(UserModel user) {
    try {
      getIt<FirebaseService>().firestore.collection('users').add(user.toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  sendEmailResetPassword({required String email}) async {
    loadingWithText();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      NavigationManager.pushNamed(RouteName.checkEmail);
      showSnackBarCustom(
        text: 'send successfully',
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: e.code);
    } catch (e) {
      NavigationManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  logOut() async {
    await getIt<FirebaseService>().auth.signOut();
    NavigationManager.goToAndRemove(RouteName.login);
  }

  saveUser({required String email, required String password}) {
    getIt<FirebaseService>()
        .firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then(
          (value) => SharedPrefController()
              .save(UserModel.fromSnapshot(value.docs.first)),
        )
        .onError((error, stackTrace) => print(error))
        .catchError((e) => print(e));
  }
}
