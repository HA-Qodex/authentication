import 'dart:io';

import 'package:fltr_database/controllers/firebase_controller.dart';
import 'package:fltr_database/resources/colors.dart';
import 'package:fltr_database/widgets/button.dart';
import 'package:fltr_database/widgets/circle_avater.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPage extends StatelessWidget {
   ImageUploadPage({Key? key}) : super(key: key);

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
                      "It's selfie time!",
                      style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let me see how do you look like",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),

                  Stack(
                    children: [GetX<FirebaseController>(
                      builder: (controller) {
                        return Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2),
                            image:
                              controller.selectedImagePath.value==""
                              ? DecorationImage(image: AssetImage("assets/selfie.jpeg"), fit: BoxFit.cover)
                                  : DecorationImage(image: FileImage(File(controller.selectedImagePath.value)), fit: BoxFit.cover)
                          ),
                        );
                      }
                    ),

              Positioned(
                bottom: 10,
                right: 30,
                child: GestureDetector(
                  onTap: (){
                    firebaseController.pickImage(imageSource: ImageSource.gallery);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(1, 1))
                        ]),
                    child: Icon(Icons.camera_alt_outlined, color: AppColors.primary,),
                  ),
                ),
              )
                    ]
                  ),

                  SizedBox(
                    height: 150,
                  ),

                  firebaseController.isLoading.value==true
                  ? CircularProgressIndicator()
                  : AppButton(
                    onPressed: () {
                      firebaseController.userSignUp();
                    },
                    title: "Finish",
                  ),

                ]),
          )),
    );
  }
}
