import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/services/remote_services/firebase_init.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/core/widgets/appbar_custom.dart';
import 'package:medical_devices_app/modules/category/controller/category_controller.dart';
import 'package:medical_devices_app/modules/home/model/device_model.dart';
import 'package:medical_devices_app/modules/order/controller/order_controller.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class DeviceDetailsView extends StatefulWidget {
  const DeviceDetailsView({
    super.key,
    required this.deviceModel,
  });
  final DeviceModel deviceModel;

  @override
  State<DeviceDetailsView> createState() => _DeviceDetailsViewState();
}

class _DeviceDetailsViewState extends State<DeviceDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryController>().getLastAddedDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: widget.deviceModel.name),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: Image.network(
                  widget.deviceModel.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.deviceModel.name,
                      style: context.h1,
                    ),
                    Text(
                      '${widget.deviceModel.price} \$',
                      style: context.h1.copyWith(
                        color: ColorManager.blue,
                      ),
                    ),
                    Text(
                      widget.deviceModel.details,
                      style: context.b1.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'منتجات ذات صلة',
                  style: context.h1.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<CategoryController>(
                  builder: (context, categoryController, child) {
                return SizedBox(
                  height: 190,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(right: 20),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (categoryController.lastAddedDevices.status ==
                          Status.COMPLETED) {
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamedReplacement(
                                RouteName.devicesDetailsView,
                                arguments: categoryController
                                    .lastAddedDevices.data![index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 140,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.network(
                                  height: 120,
                                  categoryController
                                      .lastAddedDevices.data![index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                categoryController
                                    .lastAddedDevices.data![index].name,
                                style: context.b1.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'USD ${categoryController.lastAddedDevices.data![index].price}',
                                style: context.b1.copyWith(
                                  color: ColorManager.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (categoryController.lastAddedDevices.status ==
                          Status.ERROR) {
                        return const Icon(
                          Icons.error,
                          size: 50,
                        );
                      } else {
                        return SkeletonItem(
                            child: Container(
                          width: 150,
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                        ));
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                );
              })
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  context
                      .read<CategoryController>()
                      .addToCart(widget.deviceModel);
                  context.read<OrderController>().getCartDevices();
                },
                child: Text('اضافة للسلة')),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
