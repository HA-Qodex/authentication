import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fltr_database/controllers/firebase_controller.dart';
import 'package:fltr_database/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          GetX<FirebaseController>(
            builder: (controller) {
              return Text(
                "You are ${controller.getID}",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              );
            }
          ),

          GetX<FirebaseController>(
            builder: (controller) {
              return Expanded(
                child: FirebaseAnimatedList(
                    itemBuilder: (context, DataSnapshot snapshot, Animation<double> animation,  index){
                  return ListTile(
                    title: Text("${controller.userDataList[index].name}", style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                    subtitle: Text("${controller.userDataList[index].phone}", style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2),
                          image:
                          controller.userDataList[index].imageUrl !=""
                              ? DecorationImage(image: NetworkImage("${controller.userDataList[index].imageUrl}"), fit: BoxFit.cover)
                              : DecorationImage(image: AssetImage("assets/selfie.jpeg"), fit: BoxFit.cover)
                      ),
                    ),
                  );
                }, query: controller.firebaseDatabase,),
              );
            }
          ),
        ],
      ),),
    );
  }
}
