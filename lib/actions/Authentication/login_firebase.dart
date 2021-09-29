import 'package:casslab/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebase {
  Future<bool> checkLoginAttemptIsCorrect(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showInSnackBar('No user found for that email.',
            title: "Authentication");
      } else if (e.code == 'wrong-password') {
        showInSnackBar('Wrong password provided for that user.',
            title: "Authentication");
      }
      return false;
    } catch (e) {
      showInSnackBar('something went wrong', title: "Authentication");
      return false;
    }
  }

  Future<bool> checkUserIsLoggedIn() async {
    User? userData;
    await FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      user = userData;
      print(user == null);
    });
    print(userData);

    return true;
  }

  signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
