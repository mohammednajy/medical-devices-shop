import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/modules/order/controller/order_controller.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom(
      {super.key,
      required this.title,
      this.height = 70,
      this.bottom,
      this.showCart = false});
  final String title;
  final double height;
  final PreferredSizeWidget? bottom;
  final bool showCart;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      title: Text(
        title,
        style: context.h1,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: height,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: showCart
          ? [
              Consumer<OrderController>(
                builder: (context, value, child) => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                        onPressed: () {
                          NavigationManager.pushNamed(RouteName.cartView);
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: ColorManager.blue,
                          size: 30,
                        )),
                    Visibility(
                      visible: value.cart.status == Status.COMPLETED
                          ? value.cart.data!.isEmpty
                              ? false
                              : true
                          : false,
                      child: const Icon(
                        Icons.circle,
                        color: Colors.amber,
                        size: 17,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
