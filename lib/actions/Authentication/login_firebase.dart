import 'package:casslab/actions/Syncing/sync_favourites.dart';
import 'package:casslab/components/loader.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFirebase {
  Future<bool> checkLoginAttemptIsCorrect(String email, String password) async {
    try {
      Loader().showLoader(Get.context!);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await SyncFavourites().startSyncing();
      Navigator.pop(Get.context!);
      return true;
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = "invalid email was provided";
      }
      Navigator.pop(Get.context!);
      _loginSnackBar(message);
      return false;
    } catch (e) {
      Navigator.pop(Get.context!);
      _loginSnackBar('Something went wrong.');
      return false;
    }
  }

  Stream<User?> checkUserIsLoggedIn() {
    return FirebaseAuth.instance.idTokenChanges();
  }

  signUserOut() {
    return FirebaseAuth.instance.signOut();
  }

  _loginSnackBar(String message) {
    showInSnackBar(message, title: "Authentication");
  }

  Future<User?> getFireBaseUser() async {
    return  await FirebaseAuth.instance.idTokenChanges().first;
  }
}
