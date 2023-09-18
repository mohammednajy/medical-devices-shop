import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/utils/asset_path_manager.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/core/widgets/loading_widget.dart';
import 'package:medical_devices_app/modules/order/controller/order_controller.dart';
import 'package:provider/provider.dart';

class ActiveOrderView extends StatefulWidget {
  const ActiveOrderView({super.key});

  @override
  State<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends State<ActiveOrderView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderController>().getActiveOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
        builder: (context, orderController, child) {
      if (orderController.activeOrder.status == Status.COMPLETED) {
        if (orderController.activeOrder.data!.isEmpty) {
          return Center(
            child: Text(
              'لا يوجد طلبات قيد التنفيذ',
              style: context.h1.copyWith(
                color: ColorManager.blue,
              ),
            ),
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: orderController.activeOrder.data!.length,
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  child: Image.network(
                    orderController.activeOrder.data![index].deviceModel.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderController.activeOrder.data![index].deviceModel.name,
                      style: context.h1.copyWith(fontSize: 17),
                    ),
                    Text(
                      '${orderController.activeOrder.data![index].deviceModel.price} \$',
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
      } else if (orderController.activeOrder.status == Status.ERROR) {
        return Text('something went wrong');
      } else {
        return loading();
      }
    });
  }
}
