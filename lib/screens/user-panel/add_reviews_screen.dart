import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/order-model.dart';
import 'package:e_comm/models/review_model.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
      title: Text("Thêm đánh giá"),
    ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Thêm đánh giá và bình luận của bạn"),
          SizedBox(
            height: 20.0,
          ),
          RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            productRating =rating;
            setState(() {

            });
          },
        ),
            const SizedBox(
              height: 20.0,
            ),
            const Text("Phản hồi"),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: feedbackController,
              decoration:
               const InputDecoration(
                label: Text("Chia sẻ phản hồi cua bạn")
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async{
                  EasyLoading.show(status: "Vui lòng đợi...");
              String feedback = feedbackController.text.trim();
              User? user =FirebaseAuth.instance.currentUser;
              // print(feedback);
              // print(productRating);
              ReviewModel reviewModel = ReviewModel(
                  customerName: widget.orderModel.customerName,
                  customerPhone: widget.orderModel.customerPhone,
                  customerDeviceToken: widget.orderModel.customerDeviceToken,
                  customerId: widget.orderModel.customerId,
                  feedback: feedback,
                  rating: productRating.toString(),
                  createdAt: DateTime.now(),
              );
             await FirebaseFirestore.instance
              .collection('products')
              .doc(widget.orderModel.productId)
              .collection('review')
              .doc(user!.uid)
              .set(reviewModel.toMap());

             EasyLoading.dismiss();
            },
                child: Text("Đăng bình luận"))
          ],
        ),
      ),
    );
  }
}
