import 'package:fltr_database/resources/colors.dart';
import 'package:fltr_database/views/image_upload.dart';
import 'package:fltr_database/widgets/button.dart';
import 'package:fltr_database/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/firebase_controller.dart';

class SignUpPage extends StatelessWidget {
  final firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                      "Create Account,",
                      style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign up to get started",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  AppTextField(
                    controller: firebaseController.nameController.value,
                    label: "Name",
                    hint: "Enter Name",
                    iconData: Icons.person_outline_rounded,
                    obscureText: false,
                    inputType: TextInputType.text,
                  ),
                  AppTextField(
                    controller: firebaseController.phoneController.value,
                    label: "Phone",
                    hint: "Enter Phone",
                    iconData: Icons.phone_iphone_rounded,
                    obscureText: false,
                    inputType: TextInputType.phone,
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

                  SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    onPressed: () {
                      Get.to(ImageUploadPage(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 500));
                    },
                    title: "Next",
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: height/6,
                  ),
                  InkWell(
                    onTap: () {
                      //Get.to(SignUpPage(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 500));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Feeling bore to type?",
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Sign in with phone",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ]),
                    ),
                  )

                ]),
          )),
    );
  }
}
