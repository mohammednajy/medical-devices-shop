import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/modules/bnb/controller/bnb_controller.dart';
import 'package:medical_devices_app/modules/home/controller/home_controller.dart';
import 'package:medical_devices_app/modules/order/view/order_view.dart';
import 'package:provider/provider.dart';

import '../../category/view/category_view.dart';
import '../../home/view/home_view.dart';
import '../../profile/view/profile_view.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final bnbProvider = context.watch<BnbController>();
    return Scaffold(
      body: taps[bnbProvider.selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            context.read<BnbController>().changeIndex(value);
          },
          currentIndex: bnbProvider.selectedTabIndex,
          selectedItemColor: ColorManager.blue,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.black),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'الفئات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_rate), label: 'طلباتي'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2), label: 'الملف الشخصي'),
          ]),
    );
  }
}

List<Widget> taps = [
  // ChangeNotifierProvider<HomeController>(
  //   create: (context) => HomeController(),
  //   child: const HomeView(),
  // ),
  const HomeView(),
  const CategoryView(),
  const OrdersScreen(),
  const ProfileView()
];
