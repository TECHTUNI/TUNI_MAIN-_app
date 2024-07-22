// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/provider/address_provider.dart';
// import 'address_refactor.dart';

// class AddAddress extends StatelessWidget {
//   AddAddress({Key? key}) : super(key: key);

//   final number = FirebaseAuth.instance.currentUser?.phoneNumber;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController addressLineOneController = TextEditingController();
//   final TextEditingController addressLineTwoController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();

//   bool validateInputs(BuildContext context) {
//     if (nameController.text.isEmpty) {
//       showValidationDialog(context, "Name is required.");
//       return false;
//     }
//     if (phoneNumberController.text.isEmpty) {
//       showValidationDialog(context, "Phone Number is required.");
//       return false;
//     }
//     if (phoneNumberController.text.length != 10) {
//       showValidationDialog(context, "Phone Number should be in 10 digits.");
//       return false;
//     }
//     if (addressLineOneController.text.isEmpty) {
//       showValidationDialog(context, "Address Line 1 is required.");
//       return false;
//     }
//     if (addressLineTwoController.text.isEmpty) {
//       showValidationDialog(context, "Address Line 2 is required.");
//       return false;
//     }
//     if (cityController.text.isEmpty) {
//       showValidationDialog(context, "City is required.");
//       return false;
//     }
//     if (stateController.text.isEmpty) {
//       showValidationDialog(context, "State is required.");
//       return false;
//     }
//     if (pinCodeController.text.isEmpty) {
//       showValidationDialog(context, "Pin Code is required.");
//       return false;
//     }
//     if (pinCodeController.text.length != 6 || int.tryParse(pinCodeController.text) == null) {
//       showValidationDialog(context, "Pin Code should be 6 digits.");
//       return false;
//     }
//     return true;
//   }

//   void showValidationDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Validation Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: Text("OK"),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _getCurrentLocation(BuildContext context) async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       showValidationDialog(context, "Location services are disabled.");
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         showValidationDialog(context, "Location permissions are denied.");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       showValidationDialog(context, "Location permissions are permanently denied.");
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

//     if (placemarks.isNotEmpty) {
//       Placemark placemark = placemarks.first;
//       cityController.text = placemark.locality ?? "";
//       stateController.text = placemark.administrativeArea ?? "";
//       pinCodeController.text = placemark.postalCode ?? "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     number != null ? phoneNumberController.text = number!.substring(3) : "";
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add New Address"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Divider(),
//             Container(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const AddressPageHeading(
//                     text: "Contact Details",
//                     icon: Icons.phone,
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     height: 50,
//                     child: TextFormField(
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         hintText: "   Full Name",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         const SizedBox(
//                           height: 50,
//                           width: 50,
//                           child: Center(child: Text("+91")),
//                         ),
//                         Container(
//                           height: 30,
//                           width: 1,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                           ),
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             controller: phoneNumberController,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Your Number",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Receiver will get order updates on this number",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const Divider(),
//             Container(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const AddressPageHeading(
//                     text: "Shipping Address",
//                     icon: Icons.pin_drop_outlined,
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () => _getCurrentLocation(context),
//                     child: Text("Use Current Location"),
//                   ),
//                   const SizedBox(height: 10),
//                   Column(
//                     children: [
//                       AddressPageAddress(
//                         controller: addressLineOneController,
//                         text: "Address line 1",
//                       ),
//                       const SizedBox(height: 15),
//                       AddressPageAddress(
//                         controller: addressLineTwoController,
//                         text: "Address line 2",
//                       ),
//                       const SizedBox(height: 15),
//                       AddressPageAddress(
//                         controller: cityController,
//                         text: "City",
//                       ),
//                       const SizedBox(height: 15),
//                       AddressPageAddress(
//                         controller: stateController,
//                         text: "State",
//                       ),
//                       const SizedBox(height: 15),
//                       AddressPageAddress(
//                         controller: pinCodeController,
//                         text: "Pin Code",
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Consumer<AddressProvider>(
//               builder: (context, addressProvider, child) {
//                 return TextButton(
//                   onPressed: () {
//                     if (validateInputs(context)) {
//                       Navigator.pop(context);
//                       addressProvider.addAddressToFirestore(
//                         nameController: nameController,
//                         phoneNumberController: phoneNumberController,
//                         addressLineOneController: addressLineOneController,
//                         addressLineTwoController: addressLineTwoController,
//                         cityController: cityController,
//                         stateController: stateController,
//                         pinCodeController: pinCodeController,
//                       );
//                     }
//                   },
//                   child: const Text(
//                     "Add Address",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
