


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


import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuni/presentation/pages/auth/sign_in/location/location_auto.dart';
import 'package:http/http.dart' as http;
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

}) 
{
  final address = AddressRepository();
  return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.phone),
                      ),
                      Text(
                        'Contact Details',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 2),
                  SizedBox(height: 10),
                  buildCustomTextField(
                     controller: nameController,
                      keyboardType: TextInputType.text,
                       hintText: 'Full name',
                  ),
                  SizedBox(height: 10),
                  buildCustomTextField(
                    
                   
                     controller: phoneNumberController,
                     keyboardType: TextInputType.phone,
                      hintText:  'phone number',
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'Receiver will get updates on this number',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
  // Shipping Details Row
  Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.location_pin),
      ),
      Text(
        'Shipping Details',
        style: TextStyle(fontSize: 18),
      ),
    ],
  ),
  Divider(height: 20, thickness: 2),
  
        SizedBox(height: 10),
          buildCustomTextField(
    controller: adressLineController1,
    hintText: 'Main Address', 
    keyboardType:  TextInputType.text,
  ),

          //LocationAutoComplete(),
  // Current Live Location Text Field
// Row(
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Icon(Icons.my_location), // Icon for current location
//     ),
//     InkWell(
//       onTap: () {
//        // Handle tap event to fetch current location
//          Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>  LocationAutoComplete(),
//                         ),
//                         (route) => false,
//                       );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           'Use current live location',
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     ),
//   ],
// ),

  SizedBox(height: 10),

  // Flat/Apartment Details Text Field
  buildCustomTextField(
     controller: adressLineController2,
     hintText: 'Flat/Apartment details',
     keyboardType: TextInputType.text
  ),
  SizedBox(height: 10),

  // Floor Number Text Field
  // buildCustomTextField(
  //   adressLineController2,
  //   'Floor number',
  //   TextInputType.text,
  // ),
  SizedBox(height: 10),

  // Additional Text Fields (City, State, Pin code)
  buildCustomTextField(
     controller:  cityController,
     hintText: 'City',
      keyboardType: TextInputType.text,
  ),
  SizedBox(height: 10),

  buildCustomTextField(
     controller: StateController,
      hintText: 'State', 
      keyboardType: TextInputType.text,
  ),
  SizedBox(height: 10),

  buildCustomTextField(
     controller: pincodeController,
      hintText: 'pincode', 
      keyboardType: TextInputType.number,
      maxLength: 6,
      isPinCode: true,
  ),
  
],

              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
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
              child: Text('Add Address'),
            ),
            
          ],
         // LocationAutoComplete(),
        ),
      ),
    );
}


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

Widget buildCustomTextField({
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyboardType,
  int? maxLength,
  bool isPinCode = false,
  bool allowSpecialChars = false,
}) {
  List<TextInputFormatter> inputFormatters = [];

  // Determine input formatters based on parameters
  if (isPinCode) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    inputFormatters.add(LengthLimitingTextInputFormatter(6)); // Limit pin code to 6 digits
  } else if (keyboardType == TextInputType.phone) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    inputFormatters.add(LengthLimitingTextInputFormatter(10)); // Limit phone number to 10 digits
  } else if (keyboardType == TextInputType.text && allowSpecialChars) {
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  } else if (keyboardType == TextInputType.text) {
    inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: hintText,
          labelText: hintText,
          errorText: isPinCode && (controller.text.length != 6 && controller.text.isNotEmpty)
              ? 'Pin code must be exactly 6 digits'
              : null,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
      ),
      if (hintText == 'Phone Number')
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
          child: Text(
            'Receiver will get updates on this number',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
    ],
  );
}
// for search location widget
Widget buildSearchLocationTextField(
  TextEditingController controller,
  String hintText,
  TextInputType keyboardType, {
  required IconData prefixIcon,
  int? maxLength,
}) {
  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.singleLineFormatter,
    LengthLimitingTextInputFormatter(maxLength ?? 100), // Default max length if not provided
  ];

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      hintText: 'Search location',
      labelText: 'Search location',
      prefixIcon: Icon(prefixIcon), // Always show the provided prefixIcon
    ),
    keyboardType: TextInputType.text,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
    onChanged: (value) {
      
    },
  );
}



void _fetchCurrentLocation() async {
  // Fetching current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Do something with the position (e.g., update UI, store location data)
  print('Current location: ${position.latitude}, ${position.longitude}');
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
    // Fetch the existing address details from Firestore
    DocumentSnapshot userAddress = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .doc(id)
        .get();

    // Set the fetched data to respective text controllers
    nameController.text = userAddress['Name'];
    phoneNumberController.text = userAddress['phone_number'];
    adressLineController1.text = userAddress['address'];
    adressLineController2.text = userAddress['address1'];
    cityController.text = userAddress['city'];
    StateController.text = userAddress['state'];
    pincodeController.text = userAddress['pincode'];

    // Show edit address dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Set dialog background to white
          insetPadding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Reduced padding here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with "Edit Address" in bold and big font
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Edit Address',
                      style: TextStyle(
                        fontSize: 24, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Contact Details Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Contact Details',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(height: 20, thickness: 2),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: nameController,
                          hintText: 'Full Name',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: phoneNumberController,
                          hintText: 'Phone Number',
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                 SizedBox(height: 10),
                  // Shipping Details Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Shipping Details',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(height: 20, thickness: 2),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: adressLineController1,
                          hintText: 'Main Address',
                          keyboardType: TextInputType.text,
                          allowSpecialChars: true,
                        ),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: adressLineController2,
                          hintText: 'Flat/Apartment Details',
                          keyboardType: TextInputType.text,
                          allowSpecialChars: true,
                        ),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: cityController,
                          hintText: 'City',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: StateController,
                          hintText: 'State',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10),
                        buildTextFieldForEditing(
                          controller: pincodeController,
                          hintText: 'Pincode',
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          isPinCode: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Buttons section (Cancel and Update)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          // Validate inputs before updating
                          final isValid = isTextFieldValidate([
                            nameController,
                            phoneNumberController,
                            adressLineController1,
                            adressLineController2,
                            cityController,
                            StateController,
                            pincodeController,
                          ], context);

                          if (isValid) {
                            // Update address using AddressBloc
                            context.read<AddressBloc>().add(
                                  OnEditAddressEvent(
                                    id: id,
                                    Name: nameController.text,
                                    phone_number: phoneNumberController.text,
                                    city: cityController.text,
                                    Address1: adressLineController1.text,
                                    Address2: adressLineController2.text,
                                    state: StateController.text,
                                    pincode: pincodeController.text,
                                  ),
                                );
                            Navigator.pop(context); // Close dialog after updating
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } catch (error) {
    print('Error updating address: $error');
    // Handle errors during asynchronous operation
  }
}

// Function to validate text fields
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
              content: const Text('Phone number must be exactly 10 digits.'),
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
    if (controller == controllersList[6] && controller.text.length != 6) {
      if (context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Pincode must be exactly 6 digits.'),
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

// Function to build text fields for editing
Widget buildTextFieldForEditing({
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyboardType,
  int? maxLength,
  bool isPinCode = false,
  bool allowSpecialChars = false,
}) {
  List<TextInputFormatter> inputFormatters = [];

  // Determine input formatters based on parameters
  if (isPinCode) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
  } else if (keyboardType == TextInputType.phone) {
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    inputFormatters
        .add(LengthLimitingTextInputFormatter(10)); // Limit phone number to 10 digits
  } else if (keyboardType == TextInputType.text && allowSpecialChars) {
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  } else if (keyboardType == TextInputType.text) {
    inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: hintText,
          labelText: hintText,
          errorText: isPinCode
              ? (controller.text.length != 6 && controller.text.isNotEmpty
                  ? 'Pin code must be 6 digits'
                  : null)
              : null,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
      ),
      if (hintText == 'Phone Number')
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
          child: Text(
            'Receiver will get updates on this number',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
    ],
  );
}

//new one