import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/root_controller.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          HapticFeedback.lightImpact();
          return controller.refreshScreen();
        },
        child: ListView.builder(
          itemCount: controller.shopItems.length,
          itemBuilder: (context, index) {
            final shop = controller.shopItems[index];
            return ListTile(
              tileColor: Colors.transparent,
              leading: shop.logo.isNotEmpty
                  ? Image.network(
                      '${DioClient.baseUrl}${shop.logo}',
                      width: 42.sp,
                    )
                  : SizedBox(width: 42.sp),
              title: Text(shop.name),
              subtitle: Text(
                shop.address,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Text(shop.phoneNumber),
              onTap: () => controller.selectShop(shop),
            );
          },
        ),
      );
    });
  }
}
