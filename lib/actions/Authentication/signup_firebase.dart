import 'package:casslab/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupFirebase {
  Future<bool> registerNewUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showInSnackBar('The password provided is too weak.',
            title: "User Registration");
      } else if (e.code == 'email-already-in-use') {
        showInSnackBar('The account already exists for that email.',
            title: "User Registration");
      }
      return false;
    } catch (e) {
      showInSnackBar('something went wrong', title: "User Registration");
      return false;
    }
  }
}
