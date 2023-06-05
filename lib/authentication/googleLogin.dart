import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/snackBar.dart';
import '../model/userModel.dart' as UserModel;

class GoogleServices {
  static signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if(userCredential.additionalUserInfo!.isNewUser){
      final user = UserModel.User(
            email: userCredential.user!.email!)
        .toJson();

    FirebaseFirestore.instance.collection("users").add(user).then((value) {
      user["id"] = value.id;
      value.set(user);
    }).catchError((onError)=>SnackBarUtility.showSnackBar(onError));
    }
  }
}
