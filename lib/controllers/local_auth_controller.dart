import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthController extends GetxController {
  var localAuthentication = LocalAuthentication();
  var hasFingerPrintLock = false.obs;
  var hasFaceLock = false.obs;
  var isUserVerified = false.obs;

  @override
  void onInit() {
    getAllBiometrics();
    super.onInit();
  }

  void getAllBiometrics() async {
    bool hasLocalAuthentication = await localAuthentication.canCheckBiometrics;

    if (hasLocalAuthentication) {
      List<BiometricType> availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      hasFaceLock.value = availableBiometrics.contains(BiometricType.face);
      hasFingerPrintLock.value =
          availableBiometrics.contains(BiometricType.fingerprint);
    } else {
      showSnackBar(
          title: "Error",
          message: "Local Authentication not available",
          icon: Icon(
            Icons.clear_rounded,
            color: Colors.red,
            size: 30,
          ));
    }
  }

  showSnackBar(
      {required String title, required String message, required Icon icon}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM, icon: icon);
  }

  Future<void> authenticationUser() async {
    try {
      const androidMessage = const AndroidAuthMessages(
          cancelButton: "cancel",
          goToSettingsButton: "settings",
          goToSettingsDescription: "Please set up your fingerprint",
          // biometricHint: "Verify your identity"
      );

      isUserVerified.value = await localAuthentication.authenticate(
        localizedReason: "Authenticate Yourself",
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: androidMessage,
      );

      if (isUserVerified.value) {
        showSnackBar(
            title: "Success",
            message: "you are authenticated",
            icon: Icon(
              Icons.done_rounded,
              color: Colors.green,
              size: 30,
            ));
      } else {
        showSnackBar(
            title: "Error",
            message: "Authentication failed",
            icon: Icon(
              Icons.clear_rounded,
              color: Colors.red,
              size: 30,
            ));
      }
    } on Exception catch (e) {
      showSnackBar(
          title: "Error",
          message: e.toString(),
          icon: Icon(
            Icons.clear_rounded,
            color: Colors.red,
            size: 30,
          ));
    }
  }
}
