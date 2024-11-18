import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpButton extends StatelessWidget {
  final TextEditingController phoneController;
  // final String countryCode;

  OtpButton({
    required this.phoneController,
    // required this.countryCode
  });

  Future<void> _getOtp(BuildContext context) async {
    final phoneNumber = phoneController.text.trim();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            // countryCode +
            phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OtpVerificationPage(
          //       phoneNumber: phoneNumber,
          //       verificationId: verificationId,
          //       onVerificationCompleted: ,
          //     ),
          //   ),
          // );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _getOtp(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.pink,
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'GET OTP',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
    );
  }
}
