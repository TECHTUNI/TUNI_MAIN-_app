// // ignore_for_file: must_be_immutable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../../../../../bloc/cart_bloc/cart_bloc.dart';
// import '../../../../../bloc/personal_details_bloc/personal_detail_bloc.dart';
// import '../../../../../model/product_order_model.dart';
// import '../../../bottom_navigation_bar/pages/bottom_nav_bar_page.dart';
// import '../cart_refactor.dart';
// import 'checkout_page_refactor.dart';

// class CheckOutFromCartPage extends StatefulWidget {
//   Map<String, dynamic> address = {};

//   List<OrderModel> orderList;
//   int total;

//   CheckOutFromCartPage(
//       {super.key,
//       required this.address,
//       required this.orderList,
//       required this.total});

//   @override
//   State<CheckOutFromCartPage> createState() => _CheckOutFromCartPageState();
// }

// class _CheckOutFromCartPageState extends State<CheckOutFromCartPage> {
//   Razorpay _razorpay = Razorpay();

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

//   final User user = FirebaseAuth.instance.currentUser!;

//   int? selectedIndex;

//   // int total = 0;

//   @override
//   Widget build(BuildContext context) {
//     final userId = user.uid;
//     final email = user.email ?? "";
//     var firstName;
//     var lastName;
//     var mobile;
//     // int calculateTotal(List<String> idList) {
//     //   for (var item in cartItems) {
//     //     int price = int.parse(item.price);
//     //     int quantity = item.quantity;
//     //     int totalPrice = price * quantity;
//     //     total += totalPrice;
//     //   }
//     //   return total;
//     // }

//     // total = calculateTotal(widget.cartItem);
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
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BottomNavBarPage(),
//                             ),
//                             (route) => false);
//                       },
//                       icon: const Icon(Icons.home),
//                       label: const Text('Shop more'))
//                 ],
//               );
//             },
//           );
//         } else if (state is RazorPaymentFailedState) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BottomNavBarPage(),
//               ),
//               (route) => false);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 // total = widget.total;
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
//                         .doc(email)
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
//                         return Center(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text('No personal Details added'),
//                             TextButton(
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
//                                                       mobileNumberController,
//                                                   hintText: 'Mobile no.'),
//                                             ],
//                                           ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: const Text(
//                                                 'cancel',
//                                                 style: TextStyle(
//                                                     color: Colors.red),
//                                               )),
//                                           TextButton(
//                                               onPressed: () {
//                                                 context
//                                                     .read<PersonalDetailBloc>()
//                                                     .add(OnAddPersonalDetailsEvent(
//                                                         name:
//                                                             nameController.text,
//                                                         phone:
//                                                             mobileNumberController
//                                                                 .text));
//                                                 Navigator.pop(context);
//                                               },
//                                               child: const Text('Add')),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text('Add personal details')),
//                           ],
//                         ));
//                       } else {
//                         firstName = snapshot.data!.get('name');
//                         // lastName = snapshot.data!.get('last_name');
//                         mobile = snapshot.data!.get('phone_number');
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             cartCheckoutSubHeadings(
//                                 headingName: 'MY INFORMATION'),
//                             SizedBox(
//                               height: screenHeight * .01,
//                             ),
//                             Text("$firstName $lastName"),
//                             SizedBox(
//                               height: screenHeight * .01,
//                             ),
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
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                     height: 50,
//                     width: screenWidth * .9,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           context.read<CartBloc>().add(RazorPayEvent(
//                                 context: context,
//                                 name: firstName,
//                                 email: user.email!,
//                                 mobile: mobile,
//                                 amount: widget.total,
//                                 orderList: widget.orderList,
//                                 address: widget.address,
//                               ));
//                         },
//                         child: const Text(
//                           "RAZORPAY",
//                           style: TextStyle(letterSpacing: 2),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueGrey,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))))),
//               ],
//             ),
//           ),
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tuni/core/model/product_order_model.dart';
import 'package:tuni/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:tuni/presentation/bloc/personal_details_bloc/personal_detail_bloc.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

import '../cart_refactor.dart';
import 'checkout_page_refactor.dart';

class CheckOutFromCartPage extends StatefulWidget {
  Map<String, dynamic> address = {};

  List<OrderModel> orderList;
  int total;

  CheckOutFromCartPage(
      {super.key,
      required this.address,
      required this.orderList,
      required this.total});

  @override
  State<CheckOutFromCartPage> createState() => _CheckOutFromCartPageState();
}

class _CheckOutFromCartPageState extends State<CheckOutFromCartPage> {
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  final User user = FirebaseAuth.instance.currentUser!;

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final email = user.email ?? "";
    var firstName;
    var lastName;
    var mobile;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is RazorPaymentSuccessState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Order Successful'),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBarPage(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Shop more'),
                  )
                ],
              );
            },
          );
        } else if (state is RazorPaymentFailedState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBarPage(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            'CHECKOUT',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * .14,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * .05,
                    top: screenHeight * .02,
                    right: screenWidth * .05,
                    bottom: screenHeight * .02,
                  ),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('personal_details')
                        .doc('personal_details')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Facing some error'),
                        );
                      } else if (!snapshot.hasData || !snapshot.data!.exists) {
                        print('hiii');
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No personal Details added'),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("PERSONAL DETAILS"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              personalDetailsTextFormField(
                                                  controller: nameController,
                                                  hintText: 'Name'),
                                              const SizedBox(height: 10),
                                              personalDetailsTextFormField(
                                                  controller:
                                                      lastnameController,
                                                  hintText: 'lastname'),
                                              const SizedBox(height: 10),
                                              personalDetailsTextFormField1(
                                                  controller:
                                                      mobileNumberController,
                                                  hintText: 'Mobile no.'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'cancel',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (validateInputs1([
                                                nameController,
                                                mobileNumberController,
                                              ], context)) {
                                                context
                                                    .read<PersonalDetailBloc>()
                                                    .add(
                                                      OnAddPersonalDetailsEvent(
                                                        number:
                                                            nameController.text,
                                                        firstName:
                                                            nameController.text,
                                                        lastName:
                                                            lastnameController
                                                                .text,
                                                      ),
                                                    );

                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Add personal details'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        firstName = snapshot.data!.get('first_name');
                        lastName = snapshot.data!.get('last_name');
                        mobile = snapshot.data!.get('phone_number');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cartCheckoutSubHeadings(
                                headingName: 'MY INFORMATION'),
                            SizedBox(height: screenHeight * .01),
                            Text("$firstName $lastName"),
                            SizedBox(height: screenHeight * .01),
                            Text(email),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CheckOutPageAddressView(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  address: widget.address),
              const SizedBox(height: 15),
              CheckoutPageTotalPayableView(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  total: widget.total)
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: screenWidth * .8,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(
                            RazorPayEvent(
                              context: context,
                              name: firstName,
                              email: user.email!,
                              mobile: mobile,
                              amount: widget.total,
                              orderList: widget.orderList,
                              address: widget.address,
                            ),
                          );
                    },
                    child: const Text(
                      "RAZORPAY",
                      style: TextStyle(letterSpacing: 2),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool validateInputs1(List<TextEditingController> controllers,
    [BuildContext? context]) {
  for (var controller in controllers) {
    if (controller == controllers[0]) {
      // Assuming the first controller is for name
      if (controller.text.isEmpty) {
        _showErrorDialog(context, 'Name field is required.');
        return false;
      }
    } else if (controller == controllers[1]) {
      // Assuming the second controller is for phone number
      if (controller.text.isEmpty || controller.text.length < 10) {
        _showErrorDialog(context, 'Phone number must be at least 10 digits.');
        return false;
      }
    }
  }
  return true;
}

void _showErrorDialog(BuildContext? context, String message) {
  if (context != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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
