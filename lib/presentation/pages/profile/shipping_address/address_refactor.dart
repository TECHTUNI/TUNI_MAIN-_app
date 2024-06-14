// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../bloc/address_bloc/address_bloc.dart';
// import 'address_repository.dart';

// // =================================== Add New Address =========================
// Widget addNewAddress({
//   required BuildContext context,
//   required double screenHeight,
//   required double screenWidth,
//   required TextEditingController nameController,
//   required TextEditingController phoneNumberController,
//   required TextEditingController adressLineController1,
//   required TextEditingController adressLineController2,
//   required TextEditingController cityController,
//   required TextEditingController StateController,
//   required TextEditingController pincodeController,
// }) {
//   final address = AddressRepository();
//   return AlertDialog(
//     title: const Text('Add New Address'),
//     contentPadding: const EdgeInsets.all(16),
//     content: SizedBox(
//       height: screenHeight * .35,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             buildCustomTextField(nameController, 'Name', TextInputType.text),
//           const SizedBox(height: 10),
//             buildCustomTextField(phoneNumberController, 'Phone Number', TextInputType.phone),
// const SizedBox(height: 10),
// buildCustomTextField(adressLineController1, 'Address line 1', TextInputType.text, allowSpecialChars: true),
// const SizedBox(height: 10),
// buildCustomTextField(adressLineController2, 'Address line 2', TextInputType.text, allowSpecialChars: true),
// const SizedBox(height: 10),
// buildCustomTextField(cityController, 'City', TextInputType.text),
// const SizedBox(height: 10),
// buildCustomTextField(StateController, 'State', TextInputType.text),
// const SizedBox(height: 10),
// buildCustomTextField(pincodeController, 'Pin code', TextInputType.number, maxLength: 6, isPinCode: true),
//           ],
//         ),
//       ),
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//         print(phoneNumberController.text); //printing in debug
//         final validation = validateInputs([
//             nameController,
//             phoneNumberController,
//             adressLineController1,
//             adressLineController2,
//             cityController,
//             StateController,
//             pincodeController,
//           ], context);
//           if (validation== true) {
//             context.read<AddressBloc>().add(
//                   OnAddAddressEvent(
//                     Name: nameController.text,
//                     phone_number: phoneNumberController.text,
//                     city: cityController.text,
//                     Address1: adressLineController1.text,
//                      Address2: adressLineController2.text,
//                       state: StateController.text,
//                     pincode: pincodeController.text,
//                   ),
//                 );
//             address.fetchAddressFromFirestore();
//             Navigator.pop(context);
//           }
//         },
//         child: const Text('Add'),
//       ),
//     ],
//   );
// }

// // Widget addNewAddressIos({
// //   required BuildContext context,
// //   required double screenHeight,
// //   required double screenWidth,
// //   required TextEditingController phoneNumberController,
// //   required TextEditingController adressLineController1,
// //   required TextEditingController adressLineController2,
// //   required TextEditingController cityController,
// //   required TextEditingController StateController,
// //   required TextEditingController pincodeController,
// // }) {
// //   final address = AddressRepository();
// //   return CupertinoAlertDialog(
// //     title: const Text('Add New Address'),
// //     // padding: const EdgeInsets.all(16),
// //     content: SizedBox(
// //       height: screenHeight * .3,
// //       child: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 30),
// //             CupertinoTextField(
// //               controller: houseNameController,
// //               placeholder: "House Name",
// //             ),
// //             const SizedBox(height: 15),
// //             CupertinoTextField(
// //               controller: landmarkController,
// //               placeholder: "Landmark",
// //             ),
// //             const SizedBox(height: 15),
// //             CupertinoTextField(
// //               controller: cityController,
// //               placeholder: "City",
// //             ),
// //             const SizedBox(height: 15),
// //             CupertinoTextField(
// //               controller: pincodeController,
// //               placeholder: "Pin code",
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //     actions: [
// //       CupertinoDialogAction(
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //           child: const Text("Cancel")),
// //       CupertinoDialogAction(
// //           onPressed: () {
// //             if (validateInputs([
// //               houseNameController,
// //               landmarkController,
// //               cityController,
// //               pincodeController
// //             ], context)) {
// //               context.read<AddressBloc>().add(
// //                     OnAddAddressEvent(
// //                       //houseName: houseNameController.text,
// //                       //landMark: landmarkController.text,
// //                       city: cityController.text,
// //                       pincode: pincodeController.text,
// //                     ),
// //                   );

// //               address.fetchAddressFromFirestore();
// //               Navigator.pop(context);
// //             }
// //           },
// //           child: const Text(
// //             "Add Address",
// //             style: TextStyle(color: CupertinoColors.systemBlue),
// //           )),
// //     ],
// //   );
// // }

// bool validateInputs(List<TextEditingController> controllers, [BuildContext? context]) {
//   // Check if any field is empty
//   for (var controller in controllers) {
//     if (controller.text.isEmpty) {
//       _showErrorDialog(context, 'Please fill in all fields.');
//       return false;
//     }
//   }

//   // Check phone number length
//   if (controllers[1].text.length != 10 ) {
//     _showErrorDialog(context, 'Phone number must be exactly 10 digits.');
//     return false;
//   }

//   // Check pin code length
//   if (controllers.last.text.length != 6) {
//     _showErrorDialog(context, 'Pin code must be exactly 6 digits.');
//     return false;
//   }

//   return true;
// }

// void _showErrorDialog(BuildContext? context, String errorMessage) {
//   if (context != null) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(errorMessage),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// Widget buildCustomTextField(TextEditingController controller, String hintText,
//     TextInputType keyboardType, {int? maxLength, bool isPinCode = false, bool allowSpecialChars = false}) {
//   List<TextInputFormatter> inputFormatters = [];

//   // Determine input formatters based on the keyboard type
//   if (isPinCode) {
//     inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
//   } else if (keyboardType == TextInputType.phone) {
//     inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
//     inputFormatters.add(LengthLimitingTextInputFormatter(10)); // Limit to 10 digits for phone number
//   } else if (keyboardType == TextInputType.text && allowSpecialChars) {
//     inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
//   } else if (keyboardType == TextInputType.text) {
//     inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
//   }

//   return TextField(
//     controller: controller,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//       hintText: hintText,
//       labelText: hintText,
//       errorText: isPinCode ? (controller.text.length < 6 && controller.text.isNotEmpty ? 'Pin code must be 6 digits' : null) : null,
//     ),
//     keyboardType: keyboardType,
//     inputFormatters: inputFormatters,
//     maxLength: maxLength,
//   );
// }

// // =================================== Edit Address ============================

// Future editAddress({
//   required BuildContext context,
//   required double screenHeight,
//   required double screenWidth,
//   required String id,
//   required TextEditingController nameController,
//   required TextEditingController phoneNumberController,
//   required TextEditingController adressLineController1,
//   required TextEditingController adressLineController2,
//   required TextEditingController cityController,
//   required TextEditingController StateController,
//   required TextEditingController pincodeController,
// }) async {
//   try {
//     DocumentSnapshot userAddress = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid.toString())
//         .collection('address')
//         .doc(id)
//         .get();

//     TextEditingController nameController=TextEditingController();
//     TextEditingController phoneNumberController = TextEditingController();
//     TextEditingController adressLineController1 = TextEditingController();
//     TextEditingController adressLineController2 = TextEditingController();
//     TextEditingController cityController = TextEditingController();
//     TextEditingController StateController = TextEditingController();
//     TextEditingController pincodeController = TextEditingController();

//     nameController.text=userAddress['Name'];
//     phoneNumberController.text = userAddress['phone_number'];
//     adressLineController1.text = userAddress['address'];
//     adressLineController2.text = userAddress['address1'];
//     cityController.text = userAddress['city'];
//     StateController.text = userAddress['state'];
//     pincodeController.text = userAddress['pincode'];

//     //Platform.isAndroid
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text("Edit Address"),
//                 content: SizedBox(
//                   height: screenHeight * .35,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         buildTextFieldForEditting(
//                           controller: nameController,
//                           hintText: 'Name',
//                           keyboardType: TextInputType.text
//                         ),
//                         const SizedBox(height: 10),
//                         buildTextFieldForEditting(
//                           controller: phoneNumberController,
//                           hintText: 'phone number',
//                           keyboardType: TextInputType.phone
//                         ),
//                         const SizedBox(height: 10),
//                          buildTextFieldForEditting(
//                           controller: adressLineController1,
//                           hintText: 'adress line 1',
//                           keyboardType: TextInputType.text,
//                           allowSpecialChars: true,
//                         ),
//                         const SizedBox(height: 10),
//                          buildTextFieldForEditting(
//                           controller: adressLineController2,
//                           hintText: 'address line  2',
//                           keyboardType: TextInputType.text,
//                           allowSpecialChars: true,
//                         ),
//                         const SizedBox(height: 10),
//                         buildTextFieldForEditting(
//                           controller: cityController,
//                           hintText: 'City',
//                           keyboardType: TextInputType.text
//                         ),
//                         const SizedBox(height: 10),
//                         buildTextFieldForEditting(
//                           controller: StateController,
//                           hintText: 'state',
//                           keyboardType: TextInputType.text
//                         ),
//                         const SizedBox(height: 10),
//                         buildTextFieldForEditting(
//                           controller: pincodeController,
//                           hintText: 'Pincode',
//                           keyboardType:TextInputType.number,
//                           maxLength: 6,
//                           isPinCode: true
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       // if (isTextFieldValidate([
//                       //   nameController,
//                       //   phoneNumberController,
//                       //   adressLineController1,
//                       //   adressLineController2,
//                       //   cityController,
//                       //   StateController,
//                       //   pincodeController,
//                       // ])) {
//                         context.read<AddressBloc>().add(
//                               OnEditAddressEvent(
//                                 Name: nameController.text,
//                                  phone_number: phoneNumberController.text,
//                                  city: cityController.text,
//                                  Address1: adressLineController1.text,
//                                  Address2: adressLineController2.text,
//                                  state: StateController.text,
//                                  pincode: pincodeController.text,
//                                  id: id,
//                               ),
//                             );
//                       // }
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Update'),
//                   ),
//                 ],

//         );
//         },
//         );

//         // Commented out iOS part
//         // : showCupertinoDialog(
//         //     context: context,
//         //     builder: (context) {
//         //       return CupertinoAlertDialog(
//         //         title: const Text("Edit Address"),
//         //         content: SizedBox(
//         //           height: screenHeight * .3,
//         //           child: SingleChildScrollView(
//         //             child: Column(
//         //               children: [
//         //                 const SizedBox(height: 20),
//         //                 CupertinoTextField(
//         //                   controller: houseNameController,
//         //                   placeholder: "House Name",
//         //                 ),
//         //                 const SizedBox(height: 10),
//         //                 CupertinoTextField(
//         //                   controller: cityController,
//         //                   placeholder: "City",
//         //                 ),
//         //                 const SizedBox(height: 10),
//         //                 CupertinoTextField(
//         //                   controller: landMarkController,
//         //                   placeholder: "Landmark",
//         //                 ),
//         //                 const SizedBox(height: 10),
//         //                 CupertinoTextField(
//         //                   controller: pincodeController,
//         //                   placeholder: "Pincode",
//         //                 ),
//         //               ],
//         //             ),
//         //           ),
//         //         ),
//         //         actions: [
//         //           CupertinoDialogAction(
//         //             onPressed: () {
//         //               Navigator.pop(context);
//         //             },
//         //             child: const Text(
//         //               'Cancel',
//         //               style: TextStyle(color: CupertinoColors.systemRed),
//         //             ),
//         //           ),
//         //           CupertinoDialogAction(
//         //             onPressed: () async {
//         //               if (isTextFieldValidate([
//         //                 houseNameController,
//         //                 cityController,
//         //                 landMarkController,
//         //                 pincodeController,
//         //               ])) {
//         //                 context.read<AddressBloc>().add(
//         //                       OnEditAddressEvent(
//         //                         addressId: itemId,
//         //                         houseName: houseNameController.text,
//         //                         landMark: landMarkController.text,
//         //                         city: cityController.text,
//         //                         pincode: pincodeController.text,
//         //                       ),
//         //                     );
//         //               }
//         //               Navigator.pop(context);
//         //             },
//         //             child: const Text('Update'),
//         //           ),
//         //         ],
//         //       );
//         //     },
//         //   );
//   } catch (error) {
//     // Handle errors during asynchronous operation
//   }
// }

// bool isTextFieldValidate(List<TextEditingController> controllersList,
//     [BuildContext? context]) {
//   for (var controller in controllersList) {
//     if (controller.text.isEmpty) {
//       if (context != null) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Please fill in all fields.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//       return false;
//     }
//     if (controller == controllersList[0] && controller.text.length < 10) {
//       if (context != null) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Phone number must be at least 10 digits.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//       return false;
//     }
//     if (controller == controllersList[1] && controller.text.length < 6) {
//       if (context != null) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Pincode must be at least 6 digits.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//       return false;
//     }
//   }
//   return true;
// }

// Widget buildTextFieldForEditting({
//   required TextEditingController controller,
//   required String hintText,
//   required TextInputType keyboardType,
//   int? maxLength,
//   bool isPinCode = false,
//   bool allowSpecialChars = false,
// }) {
//   List<TextInputFormatter> inputFormatters = [];

//   // Determine input formatters based on the parameters
//   if (isPinCode) {
//     inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
//   } else if (keyboardType == TextInputType.phone) {
//     inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
//     inputFormatters.add(LengthLimitingTextInputFormatter(10)); // Limit to 10 digits for phone number
//   } else if (keyboardType == TextInputType.text && allowSpecialChars) {
//     inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
//   } else if (keyboardType == TextInputType.text) {
//     inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
//   }

//   return TextField(
//     controller: controller,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//       hintText: hintText,
//       labelText: hintText,
//       errorText: isPinCode ? (controller.text.length < 6 && controller.text.isNotEmpty ? 'Pin code must be 6 digits' : null) : null,
//     ),
//     keyboardType: keyboardType,
//     inputFormatters: inputFormatters,
//     maxLength: maxLength,
//   );
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/address_bloc/address_bloc.dart';
import 'address_repository.dart';

// =================================== Add New Address =========================
Widget addNewAddress({
  required BuildContext context,
  required double screenHeight,
  required double screenWidth,
  required TextEditingController nameController,
  required TextEditingController phoneNumberController,
  required TextEditingController adressLineController1,
  required TextEditingController adressLineController2,
  required TextEditingController cityController,
  required TextEditingController StateController,
  required TextEditingController pincodeController,
}) {
  final address = AddressRepository();
  return AlertDialog(
    title: const Text('Add New Address'),
    contentPadding: const EdgeInsets.all(16),
    content: SizedBox(
      height: screenHeight * .35,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildCustomTextField(nameController, 'Name', TextInputType.text),
            const SizedBox(height: 10),
            buildCustomTextField(
                phoneNumberController, 'Phone Number', TextInputType.phone),
            const SizedBox(height: 10),
            buildCustomTextField(
                adressLineController1, 'Address line 1', TextInputType.text,
                allowSpecialChars: true),
            const SizedBox(height: 10),
            buildCustomTextField(
                adressLineController2, 'Address line 2', TextInputType.text,
                allowSpecialChars: true),
            const SizedBox(height: 10),
            buildCustomTextField(cityController, 'City', TextInputType.text),
            const SizedBox(height: 10),
            buildCustomTextField(StateController, 'State', TextInputType.text),
            const SizedBox(height: 10),
            buildCustomTextField(
                pincodeController, 'Pin code', TextInputType.number,
                maxLength: 6, isPinCode: true),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          print(phoneNumberController.text); //printing in debug
          final validation = validateInputs([
            nameController,
            phoneNumberController,
            adressLineController1,
            adressLineController2,
            cityController,
            StateController,
            pincodeController,
          ], context);
          if (validation == true) {
            context.read<AddressBloc>().add(
                  OnAddAddressEvent(
                    Name: nameController.text,
                    phone_number: phoneNumberController.text,
                    city: cityController.text,
                    Address1: adressLineController1.text,
                    Address2: adressLineController2.text,
                    state: StateController.text,
                    pincode: pincodeController.text,
                  ),
                );
            address.fetchAddressFromFirestore();
            Navigator.pop(context);
          }
        },
        child: const Text('Add'),
      ),
    ],
  );
}

// Widget addNewAddressIos({
//   required BuildContext context,
//   required double screenHeight,
//   required double screenWidth,
//   required TextEditingController phoneNumberController,
//   required TextEditingController adressLineController1,
//   required TextEditingController adressLineController2,
//   required TextEditingController cityController,
//   required TextEditingController StateController,
//   required TextEditingController pincodeController,
// }) {
//   final address = AddressRepository();
//   return CupertinoAlertDialog(
//     title: const Text('Add New Address'),
//     // padding: const EdgeInsets.all(16),
//     content: SizedBox(
//       height: screenHeight * .3,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             CupertinoTextField(
//               controller: houseNameController,
//               placeholder: "House Name",
//             ),
//             const SizedBox(height: 15),
//             CupertinoTextField(
//               controller: landmarkController,
//               placeholder: "Landmark",
//             ),
//             const SizedBox(height: 15),
//             CupertinoTextField(
//               controller: cityController,
//               placeholder: "City",
//             ),
//             const SizedBox(height: 15),
//             CupertinoTextField(
//               controller: pincodeController,
//               placeholder: "Pin code",
//             ),
//           ],
//         ),
//       ),
//     ),
//     actions: [
//       CupertinoDialogAction(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text("Cancel")),
//       CupertinoDialogAction(
//           onPressed: () {
//             if (validateInputs([
//               houseNameController,
//               landmarkController,
//               cityController,
//               pincodeController
//             ], context)) {
//               context.read<AddressBloc>().add(
//                     OnAddAddressEvent(
//                       //houseName: houseNameController.text,
//                       //landMark: landmarkController.text,
//                       city: cityController.text,
//                       pincode: pincodeController.text,
//                     ),
//                   );

//               address.fetchAddressFromFirestore();
//               Navigator.pop(context);
//             }
//           },
//           child: const Text(
//             "Add Address",
//             style: TextStyle(color: CupertinoColors.systemBlue),
//           )),
//     ],
//   );
// }

bool validateInputs(List<TextEditingController> controllers,
    [BuildContext? context]) {
  // Check if any field is empty
  for (var controller in controllers) {
    if (controller.text.isEmpty) {
      _showErrorDialog(context, 'Please fill in all fields.');
      return false;
    }
  }

  // Check phone number length
  if (controllers[1].text.length != 10) {
    _showErrorDialog(context, 'Phone number must be exactly 10 digits.');
    return false;
  }

  // Check pin code length
  if (controllers.last.text.length != 6) {
    _showErrorDialog(context, 'Pin code must be exactly 6 digits.');
    return false;
  }

  return true;
}

void _showErrorDialog(BuildContext? context, String errorMessage) {
  if (context != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
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
  }
}

Widget buildCustomTextField(TextEditingController controller, String hintText,
    TextInputType keyboardType,
    {int? maxLength, bool isPinCode = false, bool allowSpecialChars = false}) {
  List<TextInputFormatter> inputFormatters = [];

  // Determine input formatters based on the keyboard type
  if (isPinCode) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
  } else if (keyboardType == TextInputType.phone) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    inputFormatters.add(LengthLimitingTextInputFormatter(
        10)); // Limit to 10 digits for phone number
  } else if (keyboardType == TextInputType.text && allowSpecialChars) {
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  } else if (keyboardType == TextInputType.text) {
    inputFormatters
        .add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
  }

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      hintText: hintText,
      labelText: hintText,
      errorText: isPinCode
          ? (controller.text.length < 6 && controller.text.isNotEmpty
              ? 'Pin code must be 6 digits'
              : null)
          : null,
    ),
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
  );
}

// =================================== Edit Address ============================

Future editAddress({
  required BuildContext context,
  required double screenHeight,
  required double screenWidth,
  required String id,
  required TextEditingController nameController,
  required TextEditingController phoneNumberController,
  required TextEditingController adressLineController1,
  required TextEditingController adressLineController2,
  required TextEditingController cityController,
  required TextEditingController StateController,
  required TextEditingController pincodeController,
}) async {
  try {
    DocumentSnapshot userAddress = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('address')
        .doc(id)
        .get();

    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController adressLineController1 = TextEditingController();
    TextEditingController adressLineController2 = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController StateController = TextEditingController();
    TextEditingController pincodeController = TextEditingController();

    nameController.text = userAddress['Name'];
    phoneNumberController.text = userAddress['phone_number'];
    adressLineController1.text = userAddress['address'];
    adressLineController2.text = userAddress['address1'];
    cityController.text = userAddress['city'];
    StateController.text = userAddress['state'];
    pincodeController.text = userAddress['pincode'];

    //Platform.isAndroid
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Address"),
          content: SizedBox(
            height: screenHeight * .35,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildTextFieldForEditting(
                      controller: nameController,
                      hintText: 'Name',
                      keyboardType: TextInputType.text),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                      controller: phoneNumberController,
                      hintText: 'phone number',
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                    controller: adressLineController1,
                    hintText: 'adress line 1',
                    keyboardType: TextInputType.text,
                    allowSpecialChars: true,
                  ),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                    controller: adressLineController2,
                    hintText: 'address line  2',
                    keyboardType: TextInputType.text,
                    allowSpecialChars: true,
                  ),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                      controller: cityController,
                      hintText: 'City',
                      keyboardType: TextInputType.text),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                      controller: StateController,
                      hintText: 'state',
                      keyboardType: TextInputType.text),
                  const SizedBox(height: 10),
                  buildTextFieldForEditting(
                      controller: pincodeController,
                      hintText: 'Pincode',
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      isPinCode: true),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                print(phoneNumberController.text);
                final validation1 = isTextFieldValidate([
                  nameController,
                  phoneNumberController,
                  adressLineController1,
                  adressLineController2,
                  cityController,
                  StateController,
                  pincodeController,
                ], context);
                if (validation1 == true) {
                  context.read<AddressBloc>().add(
                        OnEditAddressEvent(
                          Name: nameController.text,
                          phone_number: phoneNumberController.text,
                          city: cityController.text,
                          Address1: adressLineController1.text,
                          Address2: adressLineController2.text,
                          state: StateController.text,
                          pincode: pincodeController.text,
                          id: id,
                        ),
                      );
                  // }
                  Navigator.pop(context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    // Commented out iOS part
    // : showCupertinoDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: const Text("Edit Address"),
    //         content: SizedBox(
    //           height: screenHeight * .3,
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 const SizedBox(height: 20),
    //                 CupertinoTextField(
    //                   controller: houseNameController,
    //                   placeholder: "House Name",
    //                 ),
    //                 const SizedBox(height: 10),
    //                 CupertinoTextField(
    //                   controller: cityController,
    //                   placeholder: "City",
    //                 ),
    //                 const SizedBox(height: 10),
    //                 CupertinoTextField(
    //                   controller: landMarkController,
    //                   placeholder: "Landmark",
    //                 ),
    //                 const SizedBox(height: 10),
    //                 CupertinoTextField(
    //                   controller: pincodeController,
    //                   placeholder: "Pincode",
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         actions: [
    //           CupertinoDialogAction(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: const Text(
    //               'Cancel',
    //               style: TextStyle(color: CupertinoColors.systemRed),
    //             ),
    //           ),
    //           CupertinoDialogAction(
    //             onPressed: () async {
    //               if (isTextFieldValidate([
    //                 houseNameController,
    //                 cityController,
    //                 landMarkController,
    //                 pincodeController,
    //               ])) {
    //                 context.read<AddressBloc>().add(
    //                       OnEditAddressEvent(
    //                         addressId: itemId,
    //                         houseName: houseNameController.text,
    //                         landMark: landMarkController.text,
    //                         city: cityController.text,
    //                         pincode: pincodeController.text,
    //                       ),
    //                     );
    //               }
    //               Navigator.pop(context);
    //             },
    //             child: const Text('Update'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
  } catch (error) {
    // Handle errors during asynchronous operation
  }
}

bool isTextFieldValidate(List<TextEditingController> controllersList,
    [BuildContext? context]) {
  for (var controller in controllersList) {
    if (controller.text.isEmpty) {
      if (context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please fill in all fields.'),
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
      }
      return false;
    }
    if (controller == controllersList[1] && controller.text.length != 10) {
      if (context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Phone number must be at least 10 digits.'),
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
      }
      return false;
    }
    if (controller == controllersList[6] && controller.text.length < 6) {
      if (context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Pincode must be at least 6 digits.'),
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
      }
      return false;
    }
  }
  return true;
}

Widget buildTextFieldForEditting({
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyboardType,
  int? maxLength,
  bool isPinCode = false,
  bool allowSpecialChars = false,
}) {
  List<TextInputFormatter> inputFormatters = [];

  // Determine input formatters based on the parameters
  if (isPinCode) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
  } else if (keyboardType == TextInputType.phone) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    inputFormatters.add(LengthLimitingTextInputFormatter(
        10)); // Limit to 10 digits for phone number
  } else if (keyboardType == TextInputType.text && allowSpecialChars) {
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  } else if (keyboardType == TextInputType.text) {
    inputFormatters
        .add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
  }

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      hintText: hintText,
      labelText: hintText,
      errorText: isPinCode
          ? (controller.text.length < 6 && controller.text.isNotEmpty
              ? 'Pin code must be 6 digits'
              : null)
          : null,
    ),
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
  );
}
