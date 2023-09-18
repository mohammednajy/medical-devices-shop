import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';

import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/core/widgets/appbar_custom.dart';
import 'package:medical_devices_app/core/widgets/loading_widget.dart';
import 'package:medical_devices_app/modules/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class PrivacyPolicesView extends StatefulWidget {
  const PrivacyPolicesView({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicesView> createState() => _PrivacyPolicesViewState();
}

class _PrivacyPolicesViewState extends State<PrivacyPolicesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileController>().privacyPolice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'سياسية الخصوصية'),
      body: Consumer<ProfileController>(
          builder: (context, profileController, child) {
        if (profileController.privacyPolices.status == Status.COMPLETED) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            children: [
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...profileController.privacyPolices.data!
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '• ${e.title}',
                                  style: context.h1.copyWith(fontSize: 14),
                                ),
                                Text(e.description, style: context.b1),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (profileController.privacyPolices.status == Status.ERROR) {
          return Text('something went wrong');
        } else {
          return loading();
        }
      }),
    );
  }
}
