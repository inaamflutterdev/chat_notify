import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info if it doesn't already exist
      await _saveUserInfo(userCredential.user!.uid, email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info if it doesn't already exist
      await _saveUserInfo(userCredential.user!.uid, email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user's email
  Future<String?> getCurrentUserEmail() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("Users").doc(user.uid).get();
      return snapshot.exists ? snapshot.data()!['email'] : null;
    }
    return null;
  }

  // Private method to save user info in Firestore
  Future<void> _saveUserInfo(String uid, String email) async {
    await _firestore.collection("Users").doc(uid).set({
      'uid': uid,
      'email': email,
    });
  }
}
