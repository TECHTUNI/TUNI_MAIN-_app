// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:tuni/presentation/pages/auth/sign_in/Phone_auth/Phone_auth_validation.dart';
// import '../../presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

// class LoginProvider with ChangeNotifier {
//   User? _user;
//   bool _isLoading = false;

//   User? get user => _user;

//   bool get isLoading => _isLoading;

//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   String generateReferralCode(int length) {
//     const charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

//   Future<void> checkAndGenerateReferralCode(User? user) async {
//     if (user == null) return;

//     final userDoc = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .collection("personal_details")
//         .doc("details");
//     final docSnapshot = await userDoc.get();

//     if (!docSnapshot.exists) {
//       final referralCode = generateReferralCode(8);
//       await userDoc.set({
//         'uid': user.uid ?? "",
//         'email': user.email ?? "",
//         'mobileNumber': user.phoneNumber ?? "",
//         'referralCode': referralCode,
//       });
//       print('Referral code generated: $referralCode');
//     } else {
//       print('User already exists.');
//     }
//   }

//   Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
//     print('hiiiiiiiiiiiiii');
//     setLoading(true);
//     FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithCredential(credential);
//         User? user = userCredential.user;
//         await checkAndGenerateReferralCode(user);
//         setLoading(false);
//         navigateToHomePage(context);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         setLoading(false);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setLoading(false);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpVerificationPage(
//               phoneNumber: phoneNumber,
//               verificationId: verificationId,
//               onVerificationCompleted: (user) async {
//                 await checkAndGenerateReferralCode(user);
//                 navigateToHomePage(context);
//               },
//             ),
//           ),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   void navigateToHomePage(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
//       (route) => false,
//     );
//   }

//   Future<void> signInAnonymously(BuildContext context) async {
//     setLoading(true);
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInAnonymously();
//       _user = userCredential.user;
//       setLoading(false);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
//         (route) => false,
//       );
//     } catch (e) {
//       setLoading(false);
//     }
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     setLoading(true);
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       User? user = userCredential.user;
//       await checkAndGenerateReferralCode(user);
//       setLoading(false);
//       navigateToHomePage(context);
//     } catch (e) {
//       setLoading(false);
//     }
//   }

//   Future<void> signInWithApple(BuildContext context) async {
//     setLoading(true);
//     try {
//       final rawNonce = _generateNonce();
//       final nonce = _sha256OfString(rawNonce);
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: nonce,
//       );
//       final appleAuthCredential = OAuthProvider('apple.com').credential(
//         idToken: credential.identityToken,
//         rawNonce: rawNonce,
//       );
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);
//       User? user = userCredential.user;
//       await checkAndGenerateReferralCode(user);
//       setLoading(false);
//       navigateToHomePage(context);
//     } catch (e) {
//       setLoading(false);
//     }
//   }

//   String _generateNonce([int length = 32]) {
//     const charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

//   String _sha256OfString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }
// }
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:tuni/presentation/pages/auth/sign_in/Phone_auth/Phone_auth_validation.dart';
import '../../presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

class LoginProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  String generateReferralCode(int length) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZ';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  Future<void> checkAndGenerateReferralCode(User? user) async {
    if (user == null) return;

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("personal_details")
        .doc("details");

    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      final referralCode = generateReferralCode(8);
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection("personal_details")
            .doc("details")
            .set({
          'userId': user.uid ?? "",
          'email': user.email ?? "",
          'phoneNumber': user.phoneNumber ?? "",
          'referralCode': referralCode,
        });
        print('User details stored successfully.');

        await FirebaseFirestore.instance
            .collection("referrals")
            .doc(referralCode)
            .collection("personal_details")
            .doc("details")
            .set({
          'uid': user.uid ?? "",
          'email': user.email ?? "",
          'phoneNumber': user.phoneNumber ?? "",
          'referralCode': referralCode,
          "userId": user.uid
        });

        await FirebaseFirestore.instance
            .collection("referrals")
            .doc(referralCode)
            .collection("Use_Referal_Count")
            .doc()
            .set({
          'count': 0,
          'referralCode': referralCode,
          "rewardAmount": 0,
        });
        print('Referral details stored successfully.');

        print('Referral code generated: $referralCode');
      } catch (e) {
        print('Error storing user details: $e');
      }
    } else {
      print('User already exists.');
    }
  }

  Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
    setLoading(true);
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          User? user = userCredential.user;
          if (user != null) {
            print('Phone verification completed. User: ${user.uid}');
            await checkAndGenerateReferralCode(user);
          } else {
            print('Phone verification completed, but user is null.');
          }
          setLoading(false);
          navigateToHomePage(context);
        } catch (e) {
          setLoading(false);
          print('Error in verificationCompleted: $e');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        setLoading(false);
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setLoading(false);
        print('Code sent to $phoneNumber, verificationId: $verificationId');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationPage(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
              onVerificationCompleted: (user) async {
                if (user != null) {
                  print('OTP verification completed. User: ${user.uid}');
                  await checkAndGenerateReferralCode(user);
                  navigateToHomePage(context);
                } else {
                  print('OTP verification completed, but user is null.');
                }
              },
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto-retrieval timeout for verificationId: $verificationId');
      },
      timeout: const Duration(seconds: 60),
    );
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
      (route) => false,
    );
  }

  Future<void> signInAnonymously(BuildContext context) async {
    setLoading(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      _user = userCredential.user;
      setLoading(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
        (route) => false,
      );
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      _user = userCredential.user;
      await checkAndGenerateReferralCode(_user);
      setLoading(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
        (route) => false,
      );
    } catch (e) {
      setLoading(false);
    }
  }

  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZ';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple(BuildContext context) async {
    setLoading(true);
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      _user = userCredential.user;
      await checkAndGenerateReferralCode(_user);
      setLoading(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarPage()),
        (route) => false,
      );
    } catch (e) {
      setLoading(false);
    }
  }
}
