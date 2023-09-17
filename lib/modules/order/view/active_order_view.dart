import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/utils/asset_path_manager.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';

class ActiveOrderView extends StatelessWidget {
  const ActiveOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 20,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.only(left: 15),
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                AssetPathManager.device,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أشعة الرنين المغناطيسي',
                  style: context.h1.copyWith(fontSize: 17),
                ),
                Text(
                  '400 \$',
                  style: context.b1.copyWith(
                    color: ColorManager.blue,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
