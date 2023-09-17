import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';

loadingWithText({
  String? text,
}) {
  showDialog(
      context: NavigationManager.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => Center(
            child: SizedBox(
              height: 100,
              width: 250,
              child: Dialog(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text ?? 'يرجى الانتظار....   ',
                      style: context.l1.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SpinKitDualRing(
                      color: ColorManager.blue,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ));
}

loading() {
  return const Center(
    child: SizedBox(
      height: 150,
      width: 250,
      child: SpinKitWave(
        color: ColorManager.blue,
        size: 50.0,
      ),
    ),
  );
}
