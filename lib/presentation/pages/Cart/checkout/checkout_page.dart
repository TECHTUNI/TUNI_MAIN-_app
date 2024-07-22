// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:tuni/core/model/cart_model.dart';
// import 'package:tuni/core/model/product_order_model.dart';
// import 'package:tuni/core/provider/cart_provider.dart';
// import 'package:tuni/presentation/bloc/cart_bloc/cart_bloc.dart';
// import 'package:tuni/presentation/bloc/personal_details_bloc/personal_detail_bloc.dart';
// import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

// import '../cart_refactor.dart';
// import 'checkout_page_refactor.dart';

// class CheckOutFromCartPage extends StatefulWidget {
//   Map<String, dynamic> address = {};

//   List<CartItemModel> orderList; //// changedddd
//   int total;
//   List<String> ids;

//   CheckOutFromCartPage(
//       {super.key,
//       required this.address,
//       required this.orderList,
//       required this.ids,
//       required this.total});

//   @override
//   State<CheckOutFromCartPage> createState() => _CheckOutFromCartPageState();
// }

// class _CheckOutFromCartPageState extends State<CheckOutFromCartPage> {
//   final Razorpay _razorpay = Razorpay();
//   Future razorPayCheckout(
//       {required int amount,
//       required String name,
//       required String email,
//       required Map<String, dynamic> address,
//       required String mobile,
//       required List<CartItemModel> orderList}) async {
//     Razorpay _razorpay = Razorpay();
//     CartProvider cartProvider = CartProvider();
//     try {
//       Map<String, dynamic> options = {
//         'key':
//             //  "rzp_test_TpsHVKhrkZuIUJ",
//             'rzp_live_W0t2SeLjFxX8SB',
//         'amount': amount * 100,
//         'name': 'Tuni',
//         'description': 'Payment for TUNi',
//         'timeout': 300,
//         'prefill': {
//           'contact': '8088473612',
//           'email': 'tunitechsolution@gmail.com'
//         }
//       };
//       _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//           (PaymentSuccessResponse response) {
//         cartProvider
//             .checkOut(
//                 orderList: orderList,
//                 address: address,
//                 totalPrice: widget.total,
//                 ids: widget.ids
//                 // productDetailsCombo: productDetailsCombo,
//                 // selectedItems: selectedItems,
//                 // totalPrice: totalPrice,
//                 // productQuantity: productQuantity,
//                 // productBrand: productBrand,
//                 // productCategory: productCategory,
//                 // productColor: productColor,
//                 // productDesign: productDesign,
//                 // productGender: productGender,
//                 // productId: productId,
//                 // productImageUrls: productImageUrls,
//                 // productName: productName,
//                 // productPrice: productPrice,
//                 // selectedSize: selectedSize,
//                 // type: type,
//                 // time: time,
//                 // itemCountcustomer: itemCountcustomer
//                 )
//             .then((value) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => const BottomNavBarPage(),
//               ),
//               (route) => false);
//         });
//       });

//       _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//           (PaymentFailureResponse response) {
//         showCupertinoDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return CupertinoAlertDialog(
//               title: const Text("Payment Failed"),
//               content: const Text("Something went wrong, please try again!!"),
//               actions: [
//                 CupertinoDialogAction(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => const BottomNavBarPage(),
//                       ),
//                       (route) => false,
//                     );
//                   },
//                   child: const Text("OK"),
//                 ),
//               ],
//             );
//           },
//         );
//       });

//       _razorpay.on(
//           Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {});
//       _razorpay.open(options);
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   final TextEditingController nameController = TextEditingController();

//   final TextEditingController mobileNumberController = TextEditingController();
//   final TextEditingController lastnameController = TextEditingController();

//   final User user = FirebaseAuth.instance.currentUser!;

//   int? selectedIndex;

//   @override
//   Widget build(BuildContext context) {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     final email = user.email ?? "";
//     dynamic firstName;
//     dynamic lastName;
//     dynamic mobile;

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return BlocListener<CartBloc, CartState>(
//       listener: (context, state) {
//         if (state is RazorPaymentSuccessState) {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text('Order Successful'),
//                 actions: [
//                   TextButton.icon(
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const BottomNavBarPage(),
//                         ),
//                         (route) => false,
//                       );
//                     },
//                     icon: const Icon(Icons.home),
//                     label: const Text('Shop more'),
//                   )
//                 ],
//               );
//             },
//           );
//         } else if (state is RazorPaymentFailedState) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const BottomNavBarPage(),
//             ),
//             (route) => false,
//           );
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.arrow_back)),
//           title: const Text(
//             'CHECKOUT',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               letterSpacing: 2,
//             ),
//           ),
//           centerTitle: true,
//           foregroundColor: Colors.black,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: screenWidth,
//                 height: screenHeight * .14,
//                 color: Colors.grey.shade200,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: screenWidth * .05,
//                     top: screenHeight * .02,
//                     right: screenWidth * .05,
//                     bottom: screenHeight * .02,
//                   ),
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(userId)
//                         .collection('personal_details')
//                         .doc('personal_details')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (snapshot.hasError) {
//                         return const Center(
//                           child: Text('Facing some error'),
//                         );
//                       } else if (!snapshot.hasData || !snapshot.data!.exists) {
//                         debugPrint('hiii');
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text('No personal Details added'),
//                               TextButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: const Text("PERSONAL DETAILS"),
//                                         content: SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               personalDetailsTextFormField(
//                                                   controller: nameController,
//                                                   hintText: 'Name'),
//                                               const SizedBox(height: 10),
//                                               personalDetailsTextFormField(
//                                                   controller:
//                                                       lastnameController,
//                                                   hintText: 'lastname'),
//                                               const SizedBox(height: 10),
//                                               personalDetailsTextFormField1(
//                                                   controller:
//                                                       mobileNumberController,
//                                                   hintText: 'Mobile no.'),
//                                             ],
//                                           ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: const Text(
//                                               'cancel',
//                                               style:
//                                                   TextStyle(color: Colors.red),
//                                             ),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               if (validateInputs1([
//                                                 nameController,
//                                                 mobileNumberController,
//                                               ], context)) {
//                                                 context
//                                                     .read<PersonalDetailBloc>()
//                                                     .add(
//                                                       OnAddPersonalDetailsEvent(
//                                                         number:
//                                                             nameController.text,
//                                                         firstName:
//                                                             nameController.text,
//                                                         lastName:
//                                                             lastnameController
//                                                                 .text,
//                                                       ),
//                                                     );

//                                                 Navigator.pop(context);
//                                               }
//                                             },
//                                             child: const Text('Add'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text('Add personal details'),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         firstName = snapshot.data!.get('first_name');
//                         lastName = snapshot.data!.get('last_name');
//                         mobile = snapshot.data!.get('phone_number');
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             cartCheckoutSubHeadings(
//                                 headingName: 'MY INFORMATION'),
//                             SizedBox(height: screenHeight * .01),
//                             Text("$firstName $lastName"),
//                             SizedBox(height: screenHeight * .01),
//                             Text(email),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               CheckOutPageAddressView(
//                   screenHeight: screenHeight,
//                   screenWidth: screenWidth,
//                   address: widget.address),
//               const SizedBox(height: 15),
//               CheckoutPageTotalPayableView(
//                   screenHeight: screenHeight,
//                   screenWidth: screenWidth,
//                   total: widget.total)
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           elevation: 0,
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: screenWidth * .8,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // context.read<CartBloc>().add(
//                       //       RazorPayEvent(
//                       //         context: context,
//                       //         name: firstName,
//                       //         email: user.email!,
//                       //         mobile: mobile,
//                       //         amount: widget.total,
//                       //         orderList: widget.orderList,
//                       //         address: widget.address,
//                       //       ),
//                       //     );
//                       razorPayCheckout(
//                         address: widget.address,
//                         amount: widget.total,
//                         email: user.email ?? '',
//                         mobile: mobile,
//                         name: firstName,
//                         orderList: widget.orderList,
//                       );
//                     },
//                     child: const Text(
//                       "RAZORPAY",
//                       style: TextStyle(letterSpacing: 2),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueGrey,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// bool validateInputs1(List<TextEditingController> controllers,
//     [BuildContext? context]) {
//   for (var controller in controllers) {
//     if (controller == controllers[0]) {
//       // Assuming the first controller is for name
//       if (controller.text.isEmpty) {
//         _showErrorDialog(context, 'Name field is required.');
//         return false;
//       }
//     } else if (controller == controllers[1]) {
//       // Assuming the second controller is for phone number
//       if (controller.text.isEmpty || controller.text.length < 10) {
//         _showErrorDialog(context, 'Phone number must be at least 10 digits.');
//         return false;
//       }
//     }
//   }
//   return true;
// }

// void _showErrorDialog(BuildContext? context, String message) {
//   if (context != null) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(message),
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

// Widget personalDetailsTextFormField({
//   required TextEditingController controller,
//   required String hintText,
// }) {
//   List<TextInputFormatter>? inputFormatters = [
//     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
//   ];

//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         labelText: hintText,
//       ),
//       keyboardType: TextInputType.text,
//       inputFormatters: inputFormatters,
//     ),
//   );
// }

// // Widget for capturing the mobile number
// Widget personalDetailsTextFormField1({
//   required TextEditingController controller,
//   required String hintText,
// }) {
//   List<TextInputFormatter>? inputFormatters = [
//     FilteringTextInputFormatter.digitsOnly,
//     LengthLimitingTextInputFormatter(10) // Limit input to 10 characters
//   ];

//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintText: 'Mobile Number',
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         labelText: 'Mobile Number',
//       ),
//       keyboardType: TextInputType.phone,
//       inputFormatters: inputFormatters,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuni/core/provider/checkout_provider.dart';
import '../../../../core/model/cart_model.dart';
import '../cart_refactor.dart';
import 'checkout_page_refactor.dart';
import '../../profile/profile/user_profile.dart';

class CheckOutFromCartPage extends StatelessWidget {
  final Map<String, dynamic> address;
  final List<CartItemModel> orderList;
  final int total;
  final List<String> ids;
  final bool isComboAdded;

  const CheckOutFromCartPage({
    Key? key,
    required this.address,
    required this.orderList,
    required this.total,
    required this.ids,
    required this.isComboAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => CheckOutProvider(),
      child: Consumer<CheckOutProvider>(
        builder: (context, provider, _) => Scaffold(
          appBar: AppBar(
            title: const Text("CHECKOUT"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              buildInformationCard(context, screenHeight, screenWidth),
              const SizedBox(height: 8),
              buildAddressCard(screenHeight, screenWidth),
              const SizedBox(height: 8),
              buildTotalPayableCard(screenHeight, screenWidth),
              const SizedBox(height: 20),
              Visibility(
                visible: isComboAdded,
                child: Row(
                  children: [
                    Expanded(child: buildReferralCodeInput(context, provider)),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        provider.handleReferralCodeSubmit();
                        provider.applayrefferal(
                            provider.referralCodeController.text);
                      },
                      child: Text('Verify'),
                    ),
                  ],
                ),
              ),
              if (provider.referralDetails != null) ...[
                SizedBox(height: 16.0),
                Text('Referral Details:'),
                for (var detail in provider.referralDetails!)
                  Text(detail.toString()),
              ],
              const SizedBox(height: 20),
              buildPayButton(context, screenWidth, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInformationCard(
      BuildContext context, double screenHeight, double screenWidth) {
    print(isComboAdded);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * .05,
        vertical: screenHeight * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('personal_details')
            .doc("details")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Facing some error'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No personal Details added'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserProfile()),
                      );
                    },
                    child: const Text('Add personal details'),
                  ),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>?;
            if (data == null ||
                !data.containsKey('first_name') ||
                !data.containsKey('mobileNumber') ||
                !data.containsKey('email')) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfile(),
                      ));
                },
                child: const Text("Add personal details"),
              );
            } else {
              String name = data['first_name'] ?? 'N/A';
              String phoneNumber = data['mobileNumber'] ?? 'N/A';
              String email = data['email'] ?? 'N/A';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cartCheckoutSubHeadings(headingName: 'MY INFORMATION'),
                  SizedBox(height: screenHeight * .01),
                  Text(name, style: const TextStyle(fontSize: 16)),
                  SizedBox(height: screenHeight * .01),
                  Text(phoneNumber, style: const TextStyle(fontSize: 16)),
                  SizedBox(height: screenHeight * .01),
                  Text(email, style: const TextStyle(fontSize: 16)),
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget buildAddressCard(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * .05,
        vertical: screenHeight * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckOutPageAddressView(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        address: address,
      ),
    );
  }

  Widget buildTotalPayableCard(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * .05,
        vertical: screenHeight * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckoutPageTotalPayableView(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        total: total,
      ),
    );
  }

  Widget buildReferralCodeInput(
      BuildContext context, CheckOutProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: provider.referralCodeController,
        decoration: InputDecoration(
          labelText: 'Referral Code',
          errorText: provider.referralError,
        ),
      ),
    );
  }

  Widget buildPayButton(
      BuildContext context, double screenWidth, CheckOutProvider provider) {
    return Container(
      width: screenWidth * .7,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          provider.razorPayCheckout(
            amount: total,
            address: address,
            orderList: orderList,
            total: total,
            ids: ids,
            context: context,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        child: const Text('PAY NOW'),
      ),
    );
  }
}
