import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/product-model.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screens/user-panel/product-details-screen.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('products')
          .where('isSale', isEqualTo: true)
          .get(),
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
            height: Get.height / 4.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
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
                    updatedAt: productData['updatedAt']
                );
                return Row(
                  children: [
                GestureDetector(
                  onTap: () => Get.to(()=>
                      ProductDetailsScreen(
                          productModel: productModel)),
                  child:  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: FillImageCard(
                        borderRadius: 20.0,
                        width: Get.width / 3.5,
                        heightImage: Get.height / 12,
                        imageProvider: CachedNetworkImageProvider(
                          productModel.productImages[0],
                        ),
                        title: Center(
                          child: Text(
                            productModel.productName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                        ),
                        footer: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Sale ${productModel.salePrice}",
                                style: const TextStyle(fontSize: 10.0),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            Expanded(
                              child: Text(
                                "${productModel.fullPrice}",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: AppConstant.appScendoryColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                  ],
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
