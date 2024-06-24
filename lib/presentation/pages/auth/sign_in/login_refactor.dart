import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../bottom_nav/pages/bottom_nav_bar_page.dart';
import '../sign_up/refactor.dart';
import '../sign_up/sign_up.dart';

class LoginBottomAppBar extends StatelessWidget {
  const LoginBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 0,
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Not a member?"),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ));
              },
              style:
                  TextButton.styleFrom(foregroundColor: Colors.grey.shade500),
              child: const Text(
                "Register Now",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}

class LoginCollectingEmailAndPassword extends StatelessWidget {
  const LoginCollectingEmailAndPassword({
    super.key,
    required this.emailController,
    required this.screenWidth,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final double screenWidth;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBox(height: 30),
        textFormField('Email', emailController, screenWidth),
        sizedBox(height: 15),
        textFormField('Password', passwordController, screenWidth),
        sizedBox(height: 15),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else if (state is Authenticated) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarPage(),
                  ),
                  (route) => false);
            } else if (state is AuthenticationError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Sign In Failed'),
                    content:
                        const Text("The provided credentials are incorrect."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: authSignInButton(screenWidth,
              context: context,
              email: emailController,
              password: passwordController),
        ),
        SizedBox(
          height: 35,
          width: screenWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {}, child: const Text('Forgot Password?'))
            ],
          ),
        ),
        sizedBox(height: 25),
        SizedBox(
          width: screenWidth * 0.6,
          child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarPage(),
                      ),
                      (route) => false);
                }
              },
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red)),
                  onPressed: () async {
                    try {
                      final userCredential =
                          await FirebaseAuth.instance.signInAnonymously();
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const BottomNavBarPage(),
                          ),
                          (route) => false);
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case "operation-not-allowed":
                          break;
                        default:
                      }
                    }
                  },
                  child: const Text(
                    ' + Guest Account ',
                    style: TextStyle(color: Colors.white),
                  ))),
        )
      ],
    );
  }
}

class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          signInHeading(
            'WELCOME!',
          ),
          const SizedBox(height: 10),
          const Text(
            "Login with OTP!",
            style: TextStyle(color: CupertinoColors.systemGrey),
          )
        ],
      ),
    );
  }
}

Widget authSignInButton(double screenWidth,
    {required BuildContext context,
    required TextEditingController email,
    required TextEditingController password}) {
  return SizedBox(
    width: screenWidth * 0.75,
    height: 45,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.grey.shade900,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      onPressed: () {
        if (email.text.isEmpty || password.text.isEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Empty Fields'),
                content: const Text("Mandatory fields can't be empty"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          context.read<AuthBloc>().add(
              SignInRequestEvent(email: email.text, password: password.text));
          email.clear();
          password.clear();
        }
      },
      child: const Text(
        'Sign In',
        style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget textFormField(String hintText, controller, double screenWidth) {
  return SizedBox(
    width: screenWidth * 0.75,
    child: Platform.isAndroid
        ? TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mandatory fields can't be empty";
              }
              return null;
            },
            controller: controller,
            obscureText:
                hintText == 'Password' || hintText == 'Confirm Password'
                    ? true
                    : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade500)),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          )
        : CupertinoTextField(
            controller: controller,
            obscureText:
                hintText == 'Password' || hintText == 'Confirm Password'
                    ? true
                    : false,
            placeholder: hintText,
          ),
  );
}

Widget signInHeading(String heading) {
  return Text(heading,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        letterSpacing: 3,
        fontWeight: FontWeight.w700,
      ));
}

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "Assets/logo/appleLogo.png",
            height: 25,
          ),
          const SizedBox(width: 10),
          const Text("Login with Apple")
        ],
      ),
    );
  }
}

class ContinueAsGuestButton extends StatelessWidget {
  const ContinueAsGuestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "CONTINUE AS ",
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                      TextSpan(
                        text: "GUEST",
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  try {
                    // final userCredential =
                    await FirebaseAuth.instance
                        .signInAnonymously()
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const BottomNavBarPage(),
                          ),
                          (route) => false);
                    });
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "operation-not-allowed":
                        break;
                      default:
                    }
                  }
                }),
          )
        : Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "CONTINUE AS ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "GUEST",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  try {
                    debugPrint("guest button cicked");

                    final userCredential = await FirebaseAuth.instance
                        .signInAnonymously()
                        // .then((value) {
                        // });
                        // debugPrint("user Credential: ${userCredential.toString()}");
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBarPage(),
                          ),
                          (route) => false);
                    });
                    debugPrint("after clicking");
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "operation-not-allowed":
                        break;
                      default:
                    }
                  } catch (e) {
                    debugPrint(e.toString());
                    throw e.toString();
                  }
                }),
          );
  }
}

class LoginPageORDividerLine extends StatelessWidget {
  const LoginPageORDividerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: CupertinoColors.systemGrey4,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        const SizedBox(width: 20),
        const Text("OR"),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 1,
            color: CupertinoColors.systemGrey4,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }
}

class LoginPagePhoneTextField extends StatelessWidget {
  const LoginPagePhoneTextField(
      {super.key, required this.controller, required this.text});

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: CupertinoTextField(
        padding: const EdgeInsets.only(left: 20),
        keyboardType: TextInputType.phone,
        controller: controller,
        placeholder: text,
        placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CupertinoColors.systemGrey5),
      ),
    );
  }
}
