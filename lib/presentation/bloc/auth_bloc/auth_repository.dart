import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  final fireStoreData = FirebaseFirestore.instance.collection('UserDetails');

  Future<UserCredential?> signUp(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential;
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      // sendEmail(name: 'Sebastian', senderEmail: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    // await auth.currentUser?.delete();
    await auth.signOut();
  }

  Future<void> deleteUser() async {
    await auth.currentUser?.delete();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
