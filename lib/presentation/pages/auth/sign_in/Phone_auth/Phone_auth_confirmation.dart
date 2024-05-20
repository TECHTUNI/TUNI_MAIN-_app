import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuni/presentation/pages/auth/sign_in/Phone_auth/Phone_auth_validation.dart';
import 'package:tuni/presentation/pages/auth/sign_in/login_refactor.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController phoneController = TextEditingController();

  // final countryPicker = const FlCountryCodePicker();

  bool isOtpSent = false;
  String? errorMessage;

  final String countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              border: Border.symmetric(vertical: BorderSide.none),
              middle: Text("Phone auth"),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Enter your Phone Number \nto Login/Signup.",
                              style:
                                  TextStyle(color: CupertinoColors.systemGrey),
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.info),
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: const Text("Note"),
                                        content: const Text(
                                            "This app only support in India, you don't have to enter country code. It is already fixed (+91)"),
                                        actions: [
                                          CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Close"))
                                        ],
                                      );
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: CupertinoColors.systemGrey5,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Center(child: Text("+91")),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: LoginPagePhoneTextField(
                              controller: phoneController,
                              text: "9876543210",
                            ),
                          ),
                        ],
                      ),
                      if (errorMessage != null)
                        Text(
                          errorMessage!,
                          style:
                              const TextStyle(color: CupertinoColors.systemRed),
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text("Get OTP"),
                            onPressed: () {
                              try {
                                if (_validatePhoneNumber()) {
                                  debugPrint("validated");
                                  FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber:
                                        countryCode + phoneController.text,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      debugPrint(
                                          "verificationFailed: ${e.toString()}");
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                OtpVerificationPage(
                                                    phoneNumber:
                                                        phoneController.text,
                                                    verificationId:
                                                        verificationId),
                                          ));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                }
                              } catch (e) {
                                throw e.toString();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              // border: Border.symmetric(vertical: BorderSide.none),
              title: const Text("Phone auth"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Enter your Phone Number \nto Login/Signup.",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.info,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Note"),
                                        content: const Text(
                                            "This app only support in India, you don't have to enter country code. It is already fixed (+91)"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Close"))
                                        ],
                                      );
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Center(
                                child: Text(
                              "+91",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: LoginPagePhoneTextField(
                              controller: phoneController,
                              text: "9876543210",
                            ),
                          ),
                        ],
                      ),
                      if (errorMessage != null)
                        Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            // padding: EdgeInsets.zero,
                            child: const Text("Get OTP"),
                            onPressed: () async {
                              try {
                                if (_validatePhoneNumber()) {
                                  // FirebaseAuth auth = FirebaseAuth.instance;
                                  //
                                  // await auth.verifyPhoneNumber(
                                  //   phoneNumber:
                                  //   '+44 7123 123 456'
                                  //   ,
                                  //   verificationCompleted:
                                  //       (PhoneAuthCredential credential) async {
                                  //     // ANDROID ONLY!
                                  //
                                  //     // Sign the user in (or link) with the auto-generated credential
                                  //     await auth
                                  //         .signInWithCredential(credential);
                                  //   },
                                  //   verificationFailed:
                                  //       (FirebaseAuthException error) {},
                                  //   codeSent: (String verificationId,
                                  //       int? forceResendingToken) {},
                                  //   codeAutoRetrievalTimeout:
                                  //       (String verificationId) {},
                                  // );
                                  FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber:
                                        countryCode + phoneController.text,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OtpVerificationPage(
                                                    phoneNumber:
                                                        phoneController.text,
                                                    verificationId:
                                                        verificationId),
                                          ));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                }
                              } catch (e) {
                                throw e.toString();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  bool _validatePhoneNumber() {
    String phoneNumber = phoneController.text;
    if (phoneNumber.isEmpty) {
      setState(() {
        errorMessage = "Please enter a phone number.";
      });
      return false;
    }
    String phoneNumberDigits = phoneNumber.substring(1);
    if (!phoneNumberDigits.contains(RegExp(r'^[0-9]+$'))) {
      setState(() {
        errorMessage = "Phone number must contain only digits.";
      });
      return false;
    }
    if (phoneNumberDigits.length != 9) {
      setState(() {
        errorMessage = "Phone number must have 10 digits.";
      });
      return false;
    }
    setState(() {
      errorMessage = "";
    });
    return true;
  }
}
