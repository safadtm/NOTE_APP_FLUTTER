import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app_sample/view/screen_all_notes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  ////
  final storage = FlutterSecureStorage();
///////

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        /////
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          ///
          storeTokenAndData(userCredential);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => ScreenAllNotes()),
              (route) => false);
        } catch (e) {
          ///  print("inner" + e.toString());

          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        /////
      } else {
        final snackbar = SnackBar(content: Text("Not able to sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      /// print("outer" + e.toString());

      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

///////
  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(key: "uid", value: userCredential.user!.uid.toString());
    await storage.write(key: "userCredntial", value: userCredential.toString());
    // print(userCredential.toString());
  }

////
  Future<String?> getToken() async {
    return await storage.read(key: "uid");
  }

////
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "uid");
    } catch (e) {}
  }
}
