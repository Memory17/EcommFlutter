
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/controllers/cart-price-controller.dart';
import 'package:e_comm/models/cart-model.dart';
import 'package:e_comm/screens/user-panel/checkout-screen.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Giỏ hàng'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
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
                  CartModel cartModel = CartModel(
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
                      productTotalPrice: productData['productTotalPrice']
                  );

                  //calculator price
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                      key: ObjectKey(cartModel.productId),
                      trailingActions: [
                        SwipeAction(
                          title: "Delete",
                            forceAlignmentToBoundary: true,
                            performsFirstActionWithFullSwipe: true,
                            onTap: (CompletionHandler handler)async{
                              print('deleted');
                              await FirebaseFirestore.instance
                              .collection('cart')
                                  .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                            }
                        )
                      ],
                      child: Card(
                        elevation: 5,
                        color: AppConstant.appTextColor,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppConstant.appMainColor,
                            backgroundImage:
                            NetworkImage(cartModel.productImages[0]),
                          ),
                          title: Text(cartModel.productName),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(cartModel.productTotalPrice.toString()),
                              SizedBox(
                                width: Get.width/20.0,
                              ),
                              GestureDetector(
                                onTap: ()async{
                                  if(cartModel.productQuantity >1){
                                   await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                          'productQuantity':
                                              cartModel.productQuantity -1,
                                          'productTotalPrice':
                                          (double.parse(cartModel.fullPrice) *
                                    (cartModel.productQuantity -1))
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: AppConstant.appMainColor,
                                  child: Text('-'),
                                ),
                              ),
                              SizedBox(
                                width: Get.width/20.0,
                              ),
                              GestureDetector(
                                onTap: ()async{
                                  if(cartModel.productQuantity >0){
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                      'productQuantity':
                                      cartModel.productQuantity + 1,
                                      'productTotalPrice':
                                      double.parse(cartModel.fullPrice) +
                                          double.parse(cartModel.fullPrice) *
                                          (cartModel.productQuantity -1)
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: AppConstant.appMainColor,
                                  child: Text('+'),
                                ),
                              ),
                            ],
                          ),
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

      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
                  ()=> Text(
                        "Tổng ${productPriceController.totalPrice.value.toStringAsFixed(1)}  VND",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: Container(
                width: Get.width /2.0,
                height: Get.height/ 18,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(

                  child: Text("Thanh toán",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: (){
                    Get.to(()=> CheckOutScreen());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}