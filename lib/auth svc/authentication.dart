
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      } else {}
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password, userType) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //call database to update the user data
        await databaseService(uid: user.uid).savingUserData(fullName, email,);

        return true;
      } else {}
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register worker
  Future registerworkerWithEmailAndPassword(
      String fullName, String email, String password, userType) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //call database to update the user data
        await databaseService(uid: user.uid).savingworkerData(fullName, email);

        return true;
      } else {}
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await helperFunctions.saveUserLoggedInStatus(false);
      await helperFunctions.saveUserEmailSF("");
      await helperFunctions.saveUsernameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
