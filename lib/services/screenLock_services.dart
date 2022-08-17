import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_list/services/fingerprint_services.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';

import '../screens/home_page.dart';

class ScreenLock {
  BuildContext? ctx;
  ScreenLock({this.ctx});

  final LocalAuthentication auth = LocalAuthentication();
  FingerPrintServices fingerPrintServices = FingerPrintServices();

  Future<bool?> authenticateUser({String? path, bool? authState}) async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticate) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        // Some biometrics are enrolled.
        print(availableBiometrics);
      }

      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face)) {
        // Specific types of biometrics are available.
        // Use checks like this with caution!
        // Face id
        try {
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Please authenticate to access your App');
          // ···
          if (path == "splash") {
            if (didAuthenticate) {
              Get.to(() => const MyHomePage());
            } else {
              // SystemNavigator.pop(); //This close to app entirely.
            }
          } else {
            if (didAuthenticate) {
              // save auth state!
              if (authState != null) {
                fingerPrintServices.savePrintToBox(authState);
                return authState;
              }
            }
          }
        } on PlatformException {
          // To accept fall back to pin!
        }
      }
    }
  }
}
