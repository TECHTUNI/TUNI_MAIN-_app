// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:connectivity/connectivity.dart';
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:tuni/core/provider/google_signin_provider.dart';
// import 'package:tuni/core/provider/refferal_provider.dart';
// import 'package:tuni/presentation/pages/auth/sign_in/Phone_auth/Phone_auth_confirmation.dart';
// import 'package:tuni/presentation/pages/auth/sign_in/validation/email_validation.dart';
// import 'package:tuni/presentation/pages/refferal_page/reffaral.dart';

// import '../../../bloc/auth_bloc/auth_bloc.dart';
// import '../../bottom_nav/pages/bottom_nav_bar_page.dart';
// import '../sign_up/sign_up.dart';
// import 'login_refactor.dart';

// class LogInPage extends StatefulWidget {
//   final void Function()? onTap;

//   LogInPage({Key? key, this.onTap}) : super(key: key);

//   @override
//   _LogInPageState createState() => _LogInPageState();
// }

// class _LogInPageState extends State<LogInPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   late bool isConnected;

//   @override
//   void initState() {
//     super.initState();
//     checkInternetConnectivity();
//   }

//   Future<void> checkInternetConnectivity() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       isConnected = connectivityResult != ConnectivityResult.none;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return isConnected
//         ? _buildUI(context, screenWidth, screenHeight)
//         : Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "Assets/logo/Tuni logo.png",
//                     height: 200,
//                     width: 200,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Sorry! Connection is lost',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Please make sure you have good network',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     ' And try again',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       checkInternetConnectivity();
//                     },
//                     child: const Text(
//                       'Retry',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }

//   Widget _buildUI(
//       BuildContext context, double screenWidth, double screenHeight) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Platform.isAndroid
//           ? Scaffold(
//               backgroundColor: Colors.transparent,
//               body: SafeArea(
//                 child: SizedBox(
//                   height: screenHeight,
//                   width: screenWidth,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 200,
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                   image:
//                                       AssetImage("Assets/Images/logo1.png"))),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Container(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 25.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Column(
//                               children: [
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   "Delighted to have you!",
//                                   style: loginPageJoinTextStyle(
//                                       color: Colors.black),
//                                 ),
//                                 const SizedBox(height: 20),

//                                 Platform.isIOS
//                                     ? SignInWithAppleButton(
//                                         onPressed: () async {
//                                         try {
//                                           final rawNonce = generateNonce();
//                                           final nonce =
//                                               sha256ofString(rawNonce);
//                                           final credential =
//                                               await SignInWithApple
//                                                   .getAppleIDCredential(
//                                             scopes: [
//                                               AppleIDAuthorizationScopes.email,
//                                               AppleIDAuthorizationScopes
//                                                   .fullName,
//                                             ],
//                                             nonce:
//                                                 Platform.isIOS ? nonce : null,
//                                           );
//                                           final AuthCredential
//                                               appleAuthCredential =
//                                               OAuthProvider('apple.com')
//                                                   .credential(
//                                             idToken: credential.identityToken,
//                                             rawNonce: Platform.isIOS
//                                                 ? rawNonce
//                                                 : null,
//                                             accessToken: Platform.isIOS
//                                                 ? null
//                                                 : credential.authorizationCode,
//                                           );
//                                           await FirebaseAuth.instance
//                                               .signInWithCredential(
//                                                   appleAuthCredential)
//                                               .then((value) {
//                                             Navigator.pushAndRemoveUntil(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const BottomNavBarPage(
//                                                     passedIndex: 0,
//                                                   ),
//                                                 ),
//                                                 (route) => false);
//                                           });
//                                         } catch (e) {
//                                           throw e.toString();
//                                         }
//                                       })
//                                     : const GoogleLoginButton(),
//                                 const SizedBox(height: 10),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                       // color: Colors.black,
//                                       child: const Text(
//                                         "Continue with Phone",
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const PhoneAuth(),
//                                             ));
//                                       }),
//                                 ),
//                                 const SizedBox(height: 10),

//                                 // const SizedBox(height: 10),
//                                 const ContinueAsGuestButton(),
//                                 const SizedBox(height: 20),
//                                 const LoginPageORDividerLine(),
//                                 const SizedBox(height: 20),

//                                 const Text(
//                                   "Login using Email and Password.",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 const SizedBox(height: 20),

//                                 SizedBox(
//                                   height: 45,
//                                   child: Form(
//                                     key: _formKey,
//                                     child: TextFormField(
//                                       keyboardType: TextInputType.emailAddress,
//                                       controller: emailController,
//                                       decoration: InputDecoration(
//                                           labelText: "Email",
//                                           labelStyle: TextStyle(
//                                               color: Colors.grey.shade500),
//                                           border: const OutlineInputBorder(
//                                               borderSide: BorderSide.none,
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(15))),
//                                           filled: true,
//                                           fillColor: Colors.grey.shade200),
//                                       validator: (value) {
//                                         return validateEmail(value!);
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 SizedBox(
//                                   height: 45,
//                                   child: TextFormField(
//                                     // padding: const EdgeInsets.only(left: 20),
//                                     obscureText: true,
//                                     controller: passwordController,
//                                     decoration: InputDecoration(
//                                         labelText: "Password",
//                                         labelStyle: TextStyle(
//                                             color: Colors.grey.shade500),
//                                         border: const OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(15))),
//                                         filled: true,
//                                         fillColor: Colors.grey.shade200),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween, // Align text to the left
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {
//                                         // Implement logic if needed
//                                         _showForgotPasswordDialog(context);
//                                       },
//                                       child: const Text("Forgot Password?"),
//                                     ),
//                                     // Empty container to create space between text and login button
//                                     Container(
//                                       width: 100, // Adjust width as needed
//                                     ),
//                                   ],
//                                 ),
//                                 //login button
//                                 BlocListener<AuthBloc, AuthState>(
//                                   listener: (context, state) {
//                                     if (state is LoadingState) {
//                                     } else if (state is Authenticated) {
//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const BottomNavBarPage(),
//                                           ),
//                                           (route) => false);
//                                     } else if (state is AuthenticationError) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return AlertDialog(
//                                             title: const Text('Sign In Failed'),
//                                             content: const Text(
//                                                 "Email and Password doesn't match."),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: const Text('OK'),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                   child: Center(
//                                     child: ElevatedButton(
//                                         child: const Text("Login"),
//                                         onPressed: () {
//                                           if (emailController.text.isEmpty ||
//                                               passwordController.text.isEmpty) {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return AlertDialog(
//                                                   title: const Text(
//                                                       'Empty Fields!!'),
//                                                   content: const Text(
//                                                       "Mandatory fields can't be empty"),
//                                                   actions: [
//                                                     TextButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child:
//                                                             const Text("OK")),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           } else {
//                                             context.read<AuthBloc>().add(
//                                                 SignInRequestEvent(
//                                                     email: emailController.text,
//                                                     password: passwordController
//                                                         .text));
//                                             emailController.clear();
//                                             passwordController.clear();
//                                           }
//                                         }),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Not a member? ",
//                                       style: TextStyle(
//                                           letterSpacing: 1, fontSize: 15),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const SignUpPage(),
//                                           ),
//                                           (route) => false,
//                                         );
//                                       },
//                                       child: const Text(
//                                         "Sign Up",
//                                         style: TextStyle(
//                                             color: Colors.blue,
//                                             fontWeight: FontWeight.w600
//                                             // decoration: TextDecoration.underline,
//                                             ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 30),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           : CupertinoPageScaffold(
//               backgroundColor: CupertinoColors.secondaryLabel,
//               child: SafeArea(
//                 child: SizedBox(
//                   height: screenHeight,
//                   width: screenWidth,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 200,
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                   image:
//                                       AssetImage("Assets/Images/logo1.png"))),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Container(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 25.0),
//                             decoration: BoxDecoration(
//                                 color: CupertinoColors.white,
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Column(
//                               children: [
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   "Delighted to have you!",
//                                   style: loginPageJoinTextStyle(
//                                       color: CupertinoColors.black),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 const SizedBox(height: 10),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: CupertinoButton(
//                                       padding: EdgeInsets.zero,
//                                       color: CupertinoColors.black,
//                                       child: const Text(
//                                         "Continue with Phone",
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       onPressed: () {}),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const ContinueAsGuestButton(),
//                                 const SizedBox(height: 20),
//                                 const LoginPageORDividerLine(),
//                                 const SizedBox(height: 20),
//                                 const Text(
//                                   "Login using Email and Password.",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 SizedBox(
//                                   height: 40,
//                                   child: CupertinoTextField(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     keyboardType: TextInputType.emailAddress,
//                                     controller: emailController,
//                                     placeholder: "Email",
//                                     placeholderStyle: const TextStyle(
//                                         color: CupertinoColors.systemGrey),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: CupertinoColors.systemGrey5),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 SizedBox(
//                                   height: 40,
//                                   child: CupertinoTextField(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     obscureText: true,
//                                     controller: passwordController,
//                                     placeholder: "Password",
//                                     placeholderStyle: const TextStyle(
//                                         color: CupertinoColors.systemGrey),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: CupertinoColors.systemGrey5),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 BlocListener<AuthBloc, AuthState>(
//                                   listener: (context, state) {
//                                     if (state is LoadingState) {
//                                     } else if (state is Authenticated) {
//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           CupertinoPageRoute(
//                                             builder: (context) =>
//                                                 const BottomNavBarPage(),
//                                           ),
//                                           (route) => false);
//                                     } else if (state is AuthenticationError) {
//                                       showCupertinoDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return CupertinoAlertDialog(
//                                             title: const Text('Sign In Failed'),
//                                             content: const Text(
//                                                 "Email and Password doesn't match."),
//                                             actions: [
//                                               CupertinoDialogAction(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: const Text('OK'),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                   child: Center(
//                                     child: CupertinoButton.filled(
//                                         child: const Text("Login"),
//                                         onPressed: () {
//                                           if (emailController.text.isEmpty ||
//                                               passwordController.text.isEmpty) {
//                                             showCupertinoDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CupertinoAlertDialog(
//                                                   title: const Text(
//                                                       'Empty Fields!!'),
//                                                   content: const Text(
//                                                       "Mandatory fields can't be empty"),
//                                                   actions: [
//                                                     CupertinoDialogAction(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child:
//                                                             const Text("OK")),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           } else {
//                                             context.read<AuthBloc>().add(
//                                                 SignInRequestEvent(
//                                                     email: emailController.text,
//                                                     password: passwordController
//                                                         .text));
//                                             emailController.clear();
//                                             passwordController.clear();
//                                           }
//                                         }),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Not a member? ",
//                                       style: TextStyle(
//                                           letterSpacing: 1, fontSize: 15),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushAndRemoveUntil(
//                                           context,
//                                           CupertinoPageRoute(
//                                             builder: (context) =>
//                                                 const SignUpPage(),
//                                           ),
//                                           (route) => false,
//                                         );
//                                       },
//                                       child: const Text(
//                                         "Sign Up",
//                                         style: TextStyle(
//                                             color: Colors.blue,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 30),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   void _showForgotPasswordDialog(BuildContext context) {
//     final TextEditingController forgotPasswordController =
//         TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Forgot Password'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text('Enter your email to reset your password'),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: forgotPasswordController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (forgotPasswordController.text.isNotEmpty) {
//                   context.read<AuthBloc>().add(ForgotPasswordEvent(
//                       email: forgotPasswordController.text));
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Password reset Email sent successfully'),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Reset Password'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String validateEmail(String value) {
//     // Add your email validation logic here
//     return '';
//   }

//   TextStyle loginPageJoinTextStyle({required Color color}) {
//     return TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color);
//   }
// }

// String generateNonce([int length = 32]) {
//   const charset =
//       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   final random = Random.secure();
//   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//       .join();
// }

// String sha256ofString(String input) {
//   final bytes = utf8.encode(input);
//   final digest = sha256.convert(bytes);
//   return digest.toString();
// }

// TextStyle loginPageJoinTextStyle({required Color color}) {
//   return TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color);
// }

// class GoogleLoginButton extends StatelessWidget {
//   const GoogleLoginButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashFactory: InkSplash.splashFactory,
//       splashColor: Colors.grey,
//       onTap: () {
//         GoogleSignInProvider googleAuthProvider = GoogleSignInProvider();
//         googleAuthProvider.signInWithGoogle().then((value) {
//           RefferalProvider refferalProvider = RefferalProvider();
//           final code = refferalProvider.generateRandomCode(8);
//           print(code);
//           if (value != null) {
//             // sendEmail(name: '', senderEmail: '');
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const BottomNavBarPage(
//                           passedIndex: 0,
//                         )));
//           }
//         });
//       },
//       child: Container(
//         height: 45,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade500),
//             borderRadius: BorderRadius.circular(8)),
//         width: double.infinity,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "Assets/logo/googlelogo.png",
//               height: 30,
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Sign in with Google ',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
