import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/widgets/appbar_custom.dart';
import 'package:medical_devices_app/modules/order/view/active_order_view.dart';
import 'package:medical_devices_app/modules/order/view/completed_ordered_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarCustom(
          height: 100,
          title: 'طلباتي',
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorManager.blue,
            labelStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'طلبات قيد التنفيذ',
              ),
              Tab(
                text: 'طلبات مستلمة',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrderView(),
            CompletedOrderedView(),
          ],
        ),
      ),
    );
  }
}
