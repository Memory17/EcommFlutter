import 'package:e_comm/screens/auth-ui/sign-in-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/google-sign-in-controller.dart';
import '../../utils/app-constant.dart';

class WelcomeScreen extends StatelessWidget{
   WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appScendoryColor,
        title: Text("Chào mừng đến với L-M",
        style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/splash-icon.json'),
            ),
            Container(child: Text("Cửa hàng L-M. Nơi uy tín hàng đầu!",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width /1.2,
                height: Get.height/ 12,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  icon: Image.asset('assets/images/final-google-logo.png',
                  width: Get.width/12,
                    height: Get.height/12,
                  ) ,
                  label: Text("Đăng nhập bằng Google",
                  style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: (){
                      _googleSignInController.signInWithGoogle();
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width /1.2,
                height: Get.height/ 12,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.email,
                    color: AppConstant.appTextColor,
                  ),
                  label: Text("Đăng nhập bằng email",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: (){
                    Get.to(()=> SignInScreen());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}