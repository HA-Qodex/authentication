import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltr_database/controllers/local_auth_controller.dart';
import 'package:fltr_database/models/user_model.dart';
import 'package:fltr_database/resources/colors.dart';
import 'package:fltr_database/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseController extends GetxController {
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final GetStorage? getStorage = GetStorage();

  String get getID => getStorage!.read("userID");

  var selectedImagePath = "".obs;
  var userID = "".obs;
  var imageUrl = "".obs;
  var isLoading = false.obs;

  var userDataList = <UserData>[].obs;
  var myData = UserData().obs;

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseDatabase = FirebaseDatabase.instance.reference().child("users");
  final firebaseStorage = FirebaseStorage.instance.ref("user_data");

  @override
  void onInit() {
    super.onInit();
  }

  userSignUp() async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);

      userID.value = userCredential.user!.uid;
      print("<<<<<<<<UserID: " + userID.value);
      Get.snackbar("Success", "Successfully added new user",
          icon: Icon(
            Icons.done,
            color: AppColors.primary,
          ));

      uploadImage();
      isLoading.value = false;
    } on FirebaseAuthException catch (exception) {
      isLoading.value = false;
      Get.snackbar("Failed", "Failed to create new user",
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }

  pickImage({required ImageSource imageSource}) async {
    final imagePicker = await ImagePicker().getImage(source: imageSource);
    if (imagePicker != null) {
      selectedImagePath.value = imagePicker.path;
    }
  }

  uploadImage() async {
    File file = File(selectedImagePath.value);
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var directory =
        firebaseStorage.child(userID.value).child(currentTime.toString());
    try {
      await directory.putFile(file);
      imageUrl.value = await directory.getDownloadURL();
      print("<<<<<<<<<<<Image Url: " + imageUrl.value);
      Get.snackbar("Success", "Image uploaded successfully",
          icon: Icon(
            Icons.done,
            color: AppColors.primary,
          ));
      uploadToDatabase();
    } on FirebaseException catch (exception) {
      isLoading.value = false;
      print("xxxxxxxxxxxxxxxUpload error" + exception.toString());
      print("=========Url: " + imageUrl.value);
    }
  }

  uploadToDatabase() async {
    UserData userData = UserData(
        id: userID.value,
        name: nameController.value.text,
        email: emailController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text,
        imageUrl: imageUrl.value);

    try {
      await firebaseDatabase.child(userID.value).set(userData.toJson());
      Get.snackbar("Success", "Data uploaded successfully",
          icon: Icon(
            Icons.done,
            color: AppColors.primary,
          ));
      if (userID.isNotEmpty) {
        fetchData();
      }
    } on FirebaseException catch (exception) {
      isLoading.value = false;
      print("xxxxxxxxxxxxData Error: " + exception.toString());
    }
  }

  userLogin() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);

      userID.value = userCredential.user!.uid;
      storeId();
      Get.snackbar("Success", "Successfully login",
          icon: Icon(
            Icons.done,
            color: AppColors.primary,
          ));
      if (userID.isNotEmpty) {
        fetchData();
      }
    } on FirebaseAuthException catch (exception) {
      print("xxxxxxxxLogin failed" + exception.toString());
    }
  }

  fetchData() {
    firebaseDatabase.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var data = snapshot.value;
      userDataList.clear();

      for (var key in keys) {
        UserData userData = UserData(
            id: data[key]["id"],
            name: data[key]["name"],
            phone: data[key]["phone"],
            email: data[key]["email"],
            imageUrl: data[key]["imageUrl"],
            password: data[key]["password"]);

        if (userID.value == userData.id) {
          myData.value.id = userData.id;
          myData.value.name = userData.name;
          myData.value.phone = userData.phone;
          myData.value.email = userData.email;
          myData.value.password = userData.password;
        }
        userDataList.add(userData);
      }
    });
    Get.offAll(HomePage(),
        transition: Transition.downToUp, duration: Duration(milliseconds: 500));
  }

  storeId()async{
      getStorage!.write("userID", userID.value);
      print("userID:"+getStorage!.read("userID"));

  }
}
