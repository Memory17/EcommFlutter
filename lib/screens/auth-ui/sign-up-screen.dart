import 'package:e_comm/screens/auth-ui/sign-in-screen.dart';
import 'package:e_comm/services/notification_service.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/sign-up-controller.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen>{
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context){
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConstant.appScendoryColor,
              centerTitle: true,
              title: Text("Đăng ký tài khoản",
                style: TextStyle(color: AppConstant.appTextColor) ,),

            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height /20,
                  ),
                  Container(
                    alignment: Alignment.center,
                  child: Text("Chào mừng đến với cửa hàng L-M",style: TextStyle(
                      color: AppConstant.appScendoryColor,
                      fontWeight: FontWeight.bold,
                  fontSize: 16.0),),
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
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: username,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Tên người dùng",
                              prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),

                        child: TextFormField(
                          controller: userPhone,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Điện thoại",
                              prefixIcon: Icon(Icons.phone),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),

                        child: TextFormField(
                          controller: userCity,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              hintText: "Tỉnh/Thành phố",
                              prefixIcon: Icon(Icons.location_pin),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),

                        child: Obx(
                            ()=> TextFormField(
                              controller: userPassword,
                              obscureText: signUpController.isPasswordVisible.value,
                              cursorColor: AppConstant.appScendoryColor,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                        signUpController.isPasswordVisible.toggle();
                                    },
                                      child: signUpController.isPasswordVisible.value
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                            ),
                        ),
                      ),
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
                        child: Text("Đăng ký",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: ()async{
                          NotificationService notificationService =
                          NotificationService();
                          String name = username.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String password = userPassword.text.trim();
                          String userDeviceToken = await notificationService.getDeviceToken();
                          if(name.isEmpty ||
                            email.isEmpty ||
                              phone.isEmpty||
                              city.isEmpty ||
                              password.isEmpty){
                            Get.snackbar(
                                "Error",
                                "Please enter all details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                            );
                          }else{
                            UserCredential? userCredential =
                                await signUpController.signUpMethod(
                                name,
                                email,
                                phone,
                                city,
                                password,
                                userDeviceToken,
                                );
                            if(userCredential!=null){
                              Get.snackbar(
                                "Đã gửi thông báo đến Email.",
                                "Vui lòng kiểm tra Email.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=> SignInScreen());
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height /20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn đã có tài khoản?",
                        style: TextStyle(color: AppConstant.appScendoryColor),
                      ),
                      GestureDetector(
                        onTap: ()=> Get.offAll(()=> SignInScreen()),
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            fontWeight: FontWeight.bold),
                      ),
            ),
                    ],
                  )
                ],
              ),
          ),
            ),
          );
        }

    );
  }
}