
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/controllers/cart-price-controller.dart';
import 'package:e_comm/models/cart-model.dart';
import 'package:e_comm/models/order-model.dart';
import 'package:e_comm/screens/user-panel/checkout-screen.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

import 'add_reviews_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
  Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Tất cả đơn hàng'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 8,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No products found!"),
            );
          }
          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                      productId: productData['productId'],
                      categoryId: productData['categoryId'],
                      productName: productData['productName'],
                      categoryName: productData['categoryName'],
                      salePrice: productData['salePrice'],
                      fullPrice: productData['fullPrice'],
                      productImages: productData['productImages'],
                      deliveryTime: productData['deliveryTime'],
                      isSale: productData['isSale'],
                      productDescription: productData['productDescription'],
                      createdAt: productData['createdAt'],
                      updatedAt: productData['updatedAt'],
                      productQuantity: productData['productQuantity'],
                      productTotalPrice: double.parse(productData['productTotalPrice'].toString()),
                      customerId: productData['customerId'],
                      status: productData['status'],
                      customerName: productData['customerName'],
                      customerPhone: productData['customerPhone'],
                      customerAddress: productData['customerAddress'],
                      customerDeviceToken: productData['customerDeviceToken'],
                  );

                  //calculator price
                  productPriceController.fetchProductPrice();
                  return Card(
                    elevation: 5,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage: NetworkImage(orderModel.productImages[0]),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            orderModel.productTotalPrice.toString(),
                            overflow: TextOverflow.ellipsis, // Thêm nếu muốn giới hạn text
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: orderModel.status != true
                              ? Text(
                            "Đang giao..",
                            style: TextStyle(color: Colors.green),
                          )
                              : Text(
                            "Đã nhận hàng!",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),

                    trailing: orderModel.status != true
                          ? ElevatedButton(
                        onPressed: () async {
                          try {
                            // Cập nhật trạng thái "status" trong Firestore
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(user!.uid)
                                .collection('confirmOrders')
                                .doc(productData.id) // ID của tài liệu trong Firestore
                                .update({'status': true});

                            // Hiển thị thông báo thành công
                            Get.snackbar(
                              "Thành công",
                              "Đơn hàng đã được cập nhật thành 'Đã nhận được hàng!'",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } catch (e) {
                            // Hiển thị thông báo lỗi
                            Get.snackbar(
                              "Lỗi",
                              "Không thể cập nhật trạng thái đơn hàng. Vui lòng thử lại!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: Text("Đã nhận"),
                      )
                          : ElevatedButton(
                        onPressed: () => Get.to(() => AddReviewScreen(orderModel: orderModel)),
                        child: Text("Đánh giá"),
                      ),
                    ),

                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}