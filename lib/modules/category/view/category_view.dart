import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';
import 'package:medical_devices_app/core/router/routers_name.dart';
import 'package:medical_devices_app/core/services/remote_services/base_model.dart';
import 'package:medical_devices_app/core/utils/extentions.dart';
import 'package:medical_devices_app/core/widgets/appbar_custom.dart';
import 'package:medical_devices_app/core/widgets/loading_widget.dart';
import 'package:medical_devices_app/modules/category/controller/category_controller.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryController>().getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(
          title: 'الفئات',
        ),
        body: Consumer<CategoryController>(
            builder: (context, categoryProvider, child) {
          if (categoryProvider.categories.status == Status.COMPLETED) {
            return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryProvider.categories.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      NavigationManager.pushNamed(RouteName.devicesView,
                          arguments: categoryProvider.categories.data![index]);
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            categoryProvider.categories.data![index].image,
                            height: 80,
                          ),
                          Text(
                            categoryProvider.categories.data![index].name,
                            style: context.h1.copyWith(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (categoryProvider.categories.status == Status.ERROR) {
            return Text(
                categoryProvider.categories.message ?? 'something went wrong');
          } else {
            return loading();
          }
        }));
  }
}
