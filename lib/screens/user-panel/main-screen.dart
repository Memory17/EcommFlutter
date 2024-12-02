import 'package:e_comm/screens/auth-ui/welcome-screen.dart';
import 'package:e_comm/screens/user-panel/all-categories-screen.dart';
import 'package:e_comm/screens/user-panel/all-flash-sale-products.dart';
import 'package:e_comm/screens/user-panel/cart-screen.dart';
import 'package:e_comm/services/notification_service.dart';
import 'package:e_comm/widgets/banner-widget.dart';
import 'package:e_comm/widgets/custom-drawer-widget.dart';
import 'package:e_comm/widgets/flash-sale-widget.dart';
import 'package:e_comm/widgets/heading-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/fcm_service.dart';
import '../../utils/app-constant.dart';
import '../../widgets/all-products-widget.dart';
import '../../widgets/category-widget.dart';
import 'all-products-screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen ({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState(){
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    FcmService.firebaseInit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName,
        style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: ()=>Get.to(()=> CartScreen()),
             child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,
                ),
              )
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:  Container(child: Column(
          children: [
            SizedBox(height: Get.height/90.0,
            ),
            //banners
            BannerWidget(),

            //heading
            HeadingWidget(
              headingTitle: "Danh mục sản phẩm",
              headingSubTitle: "Phù hợp với ví của bạn",
              onTap: ()=> Get.to(()=> AllCategoriesScreen()),
              buttonText: "Xem thêm >",
            ),
            CategoriesWidget(),

            HeadingWidget(
              headingTitle: "Flash Sale",
              headingSubTitle: "Số lượng có hạng. Nhanh tay đón về!",
              onTap: () => Get.to(()=> AllFlashSaleProductScreen()),
              buttonText: "Xem thêm >",
            ),
            FlashSaleWidget(),

            HeadingWidget(
              headingTitle: "Tất cả sản phẩm",
              headingSubTitle: "Xem tất cả sản pẩm tại đây",
              onTap: () => Get.to(()=> AllProductsScreen()),
              buttonText: "Xem thêm >",
            ),
            AllProductsWidget(),

          ],
        ),),
      ),
    );
  }
}