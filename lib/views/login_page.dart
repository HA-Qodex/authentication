import 'package:fltr_database/controllers/local_auth_controller.dart';
import 'package:fltr_database/resources/colors.dart';
import 'package:fltr_database/views/sign_up_page.dart';
import 'package:fltr_database/widgets/button.dart';
import 'package:fltr_database/widgets/circle_avater.dart';
import 'package:fltr_database/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/firebase_controller.dart';

class LoginPage extends StatelessWidget {

  final firebaseController = Get.put(FirebaseController());
  final authController = Get.put(LocalAuthController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: height / 25, right: height / 25),
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome,",
                      style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign in to continue!",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  AppTextField(
                    controller: firebaseController.emailController.value,
                    label: "Email ID",
                    hint: "Enter Email",
                    iconData: Icons.email_outlined,
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  AppTextField(
                    controller: firebaseController.passwordController.value,
                    label: "Password",
                    hint: "Enter Password",
                    iconData: Icons.lock_open_rounded,
                    obscureText: true,
                    inputType: TextInputType.text,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    onPressed: () {
                      print(firebaseController.getID);
                      // firebaseController.userLogin();
                    },
                    title: "Login",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: AppColors.grey,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppCircleAvater(
                        onTap: () {
                          //Todo: Add onPressed
                        },
                        image: Image.asset("assets/google.png"),
                      ),
                      AppCircleAvater(
                        onTap: () {
                          //Todo: Add onPressed
                        },
                        image: Image.asset("assets/facebook.png"),
                      ),
                      AppCircleAvater(
                        onTap: () {
                          //Todo: Add onPressed
                        },
                        image: Image.asset("assets/twitter.png"),
                      ),
                    ],
                  ),
                  SizedBox(height: height/13),
                  GetX<LocalAuthController>(
                      builder: (controller) {
                        return
                          controller.hasFingerPrintLock.value
                              ? GestureDetector(
                            onTap: (){controller.authenticationUser();},
                                child: SvgPicture.asset(
                            "assets/fingerprint.svg", color: AppColors.primary, height: 64, width: 64),
                              )
                              : SvgPicture.asset(
                            "assets/fingerprint.svg", color: AppColors.grey, height: 64, width: 64);
                      }
                  ),
                  SizedBox(height: height/13),
                  InkWell(
                    onTap: () {
                      Get.to(SignUpPage(), transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 500));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "I'm a new user,",
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: " SignUp",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
