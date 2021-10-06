import 'package:casslab/actions/Syncing/sync_favourites.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebase {
  Future<bool> checkLoginAttemptIsCorrect(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await SyncFavourites().startSyncing();

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
      _loginSnackBar(message);
      return false;
    } catch (e) {
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
