import 'package:e_comm/controllers/sign-in-controller.dart';
import 'package:e_comm/screens/auth-ui/sign-up-screen.dart';
import 'package:e_comm/screens/user-panel/main-screen.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/forget-password-controller.dart';

class ForgetPasswordScreen extends StatefulWidget{
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>{
  final ForgetPasswordController forgetPasswordController =
  Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext context){
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConstant.appScendoryColor,
              centerTitle: true,
              title: Text("Quên mật khẩu",
                style: TextStyle(color: AppConstant.appTextColor) ,),

            ),
            body: Container(
              child: Column(
                children: [
                  isKeyboardVisible? Text("Chào mừng đến với L-M"):
                  Column(
                    children: [
                      Lottie.asset('assets/images/splash-icon.json')
                    ],
                  ),
                  SizedBox(
                    height: Get.height /20,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),

                        child: TextFormField(
                          controller: userEmail,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      )
                  ),
                  SizedBox(
                    height: Get.height /20,
                  ),
                  Material(
                    child: Container(
                      width: Get.width /2,
                      height: Get.height/ 18,
                      decoration: BoxDecoration(
                        color: AppConstant.appScendoryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextButton(
                        child: Text("Xác nhận",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: () async{
                          String email  =userEmail.text.trim();
                          if(email.isEmpty){
                            Get.snackbar("Error", "Please enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,);
                          }else{
                            String email= userEmail.text.trim();
                            forgetPasswordController.ForgetPasswordMethod(email);
                          }

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

    );
  }
}