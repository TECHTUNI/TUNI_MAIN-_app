import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

class OtpVerificationPage extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;

  OtpVerificationPage(
      {super.key, required this.phoneNumber, required this.verificationId});

  final TextEditingController otpController = TextEditingController();

  // LoginPagePhoneTextField(
  // controller: otpController,
  // text: "OTP",
  // ),

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border.all(color: CupertinoColors.white),
        middle: const Text(
          "OTP Verification",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              CupertinoTextField(
                placeholder: "Enter OTP",
                controller: otpController,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 120,
                child: CupertinoButton.filled(
                    padding: EdgeInsets.zero,
                    child: const Text("Verify"),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otpController.text.toString());
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const BottomNavBarPage(passedIndex: 0),
                              ),
                              (route) => false);
                        });
                      } catch (e) {
                        debugPrint("Exception is at otp verification button");
                        throw e.toString();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
