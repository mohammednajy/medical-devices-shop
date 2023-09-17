import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/core/widgets/appbar_custom.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'الملف الشخصي'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        children: [
          const PersonalCardInfo(),
          const SizedBox(
            height: 16,
          ),
          // Card(
          //   color: Colors.white,
          //   elevation: 0,
          //   margin: const EdgeInsets.only(top: 16),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          //     child: Column(
          //       children: [
          //         ProfileCustomListTile(
          //           text: 'تغيير المعلومات الشخصية',
          //           onTap: () {},
          //         ),
          //         const Divider(
          //           thickness: 1,
          //           height: 10,
          //         ),
          //         ProfileCustomListTile(
          //           text: 'تغيير البريد الالكتروني',
          //           onTap: () {},
          //         ),
          //         const Divider(
          //           thickness: 1,
          //           height: 10,
          //         ),
          //         ProfileCustomListTile(
          //           text: 'إدارة العناوين',
          //           onTap: () async {},
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  ProfileCustomListTile(
                    text: 'تواصل معنا',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'عن التطبيق',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الاستخدام',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الخصوصية',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'الأسئلة الشائعة',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              onTap: () async {
                SharedPrefController().isLoggedIn(value: false);
                SharedPrefController().remove();
                NavigationManager.goToAndRemove(RouteName.login);
              },
              title: Text(
                'تسجيل الخروح',
              ),
              trailing: Container(
                  height: 22,
                  width: 22,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.logout_outlined,
                    size: 15,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileCustomListTile extends StatelessWidget {
  const ProfileCustomListTile({
    this.onTap,
    required this.text,
    Key? key,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Text(
        text,
        style: context.b1.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: const Icon(
          Icons.arrow_right_rounded,
          color: ColorManager.blue,
        ),
      ),
    );
  }
}

class PersonalCardInfo extends StatefulWidget {
  const PersonalCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalCardInfo> createState() => _PersonalCardInfoState();
}

class _PersonalCardInfoState extends State<PersonalCardInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 60,
            color: ColorManager.blue,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getIt<FirebaseService>().auth.currentUser?.displayName ??
                    'dumy name',
                style: context.h1,
              ),
              Text(
                getIt<FirebaseService>().auth.currentUser?.email ??
                    'emsdfdsfds@g.com',
                style: context.b1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
