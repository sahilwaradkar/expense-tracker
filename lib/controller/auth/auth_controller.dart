import 'package:assignment/screens/auth/login_screen.dart';
import 'package:assignment/screens/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_nav_bar.dart';

class AuthController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool termsNConditions = false;
  bool isPasswordVisible = false;
  bool checkBox = false;
  // final gender = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedGender;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  Future<void> signInWithGoogle(BuildContext context) async {
    // Provider.of<LoadingProvider>(context, listen: false).setLoad(true);
    try {
      if (_auth.currentUser != null) {
        print("User is already signed in: ${_auth.currentUser!.email}");
        final String loggedIn =
            "Logged in as: ${_auth.currentUser!.displayName}";
        clearControllers();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
        return;
      }

      // If no user is signed in, proceed with Google sign-in
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      print("Logged in as: ${user!.email}");
      clearControllers();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } catch (e) {
      print("Login error: $e");
    } finally {
      // Provider.of<LoadingProvider>(context, listen: false).setLoad(false);
      notifyListeners();
    }
  }

  void signUserIn(context) async {
    // Provider.of<LoadingProvider>(context, listen: false).setLoad(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', nameController.text);
    if (emailController.text.trim() == '' ||
        passwordController.text.trim() == '') {
      return;
    }
    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } catch (e) {
      print("Login error: $e");
    } finally {
      notifyListeners();
    }
  }


  void logUserOut(context) async {
    // Provider.of<LoadingProvider>(context, listen: false).setLoad(true);
    try {
      await FirebaseAuth.instance.signOut().then((_) {
        // Provider.of<LoadingProvider>(context, listen: false).setLoad(false);
        clearControllers();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()),
            ModalRoute.withName('/'));
      });
      await GoogleSignIn().disconnect();
    } catch (e) {
      print('Error signing out: $e');
    } finally {
      // Provider.of<LoadingProvider>(context, listen: false).setLoad(false);
      notifyListeners();
    }
  }

  void signUserUp(context) async {
    // Provider.of<LoadingProvider>(context, listen: false).setLoad(true);
    if (emailController.text.trim() == '' ||
        passwordController.text.trim() == '') {
      return;
    }

    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );

    } catch (e) {
      print("Login error: $e");
    } finally {
      // Provider.of<LoadingProvider>(context, listen: false).setLoad(false);
      notifyListeners();
    }
  }


  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
