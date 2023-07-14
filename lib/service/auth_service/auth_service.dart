import 'package:absensi_online/service/employee_service/employee_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

User? get currentUser {
  return FirebaseAuth.instance.currentUser;
}

class AuthService {
  doHRDLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user!.email != "muzt803@gmail.com") {
        await FirebaseAuth.instance.signOut();
        throw Exception("Unathorized access!");
      }

      //TODO: on login success
      //------------------
    } catch (_) {
      throw Exception(_);
    }
  }

  doEmployeeLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      bool isNotRegistered =
          await EmployeeService().isNotRegistered(userCredential.user!.email!);
      if (isNotRegistered) {
        await FirebaseAuth.instance.signOut();
        throw Exception("Unathorized access!");
      }
      //TODO: on login success
      //------------------
    } catch (_) {
      throw Exception(_);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
