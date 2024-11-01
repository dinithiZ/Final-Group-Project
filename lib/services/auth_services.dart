import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up method
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'created_at': DateTime.now(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign up error: ${e.message}");
      return null;
    }
  }

  // Sign in method
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign in error: ${e.message}");
      return null;
    }
  }

  // Check if an email is registered
  Future<bool> isEmailRegistered(String email) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Delete account method
  Future<void> deleteAccount() async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser?.uid).delete();
      await _auth.currentUser?.delete();
      print("Account was deleted");
    } catch (e) {
      print("Error deleting account: $e");
      rethrow;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Update user profile method
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);

      // If email is being updated, update it in Firebase Auth as well
      if (data.containsKey('email')) {
        await _auth.currentUser?.updateEmail(data['email']);
      }

      // If name is being updated, update display name in Firebase Auth
      if (data.containsKey('name')) {
        await _auth.currentUser?.updateDisplayName(data['name']);
      }
    } catch (e) {
      print("Error updating user profile: $e");
      rethrow;
    }
  }

  // Change password method
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final user = _auth.currentUser;

    if (user != null) {
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: currentPassword);

      try {
        // Re-authenticate the user
        await user.reauthenticateWithCredential(cred);

        // Update the password
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        print("Error changing password: ${e.message}");
        rethrow;
      }
    }
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
