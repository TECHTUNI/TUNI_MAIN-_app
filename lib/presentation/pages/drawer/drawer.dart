// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tuni/presentation/pages/drawer/pages_in_drawer/my_orders/user_orders.dart';
// import 'package:tuni/presentation/pages/drawer/pages_in_drawer/profile/user_profile.dart';
// import '../../bloc/home_bloc/home_bloc.dart';
//
// class DrawerWidget extends StatelessWidget {
//   DrawerWidget({super.key});
//
//   final User? user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     final userId = user!.uid;
//     final String userEmail = user?.email ?? "";
//
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("users")
//                   .doc(userId)
//                   .collection("personal_details")
//                   .doc(userEmail)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text("Error: ${snapshot.error}");
//                 }
//                 if (!snapshot.hasData || !snapshot.data!.exists) {
//                   return const Text(" ");
//                 }
//                 var name = " ";
//                 if (snapshot.hasData && snapshot.data!.exists) {
//                   var data = snapshot.data!.data() as Map<String, dynamic>;
//                   name = data["first_name"] ?? " ";
//                 }
//
//                 return Text(
//                   name,
//                   style: const TextStyle(color: Colors.black, fontSize: 20),
//                 );
//               },
//             ),
//             accountEmail: Text(userEmail),
//             decoration: BoxDecoration(color: Colors.blueGrey.shade300),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserProfile(),
//                   ));
//             },
//             child:
//                 const ListTile(leading: Icon(Icons.person), title: Text('Profile')),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserOrders(),
//                   ));
//             },
//             child: const ListTile(
//                 leading: Icon(Icons.shopping_cart_sharp),
//                 title: Text('My Orders')),
//           ),
//           InkWell(
//               onTap: () {
//                 // Navigator.push(
//                 //     context, MaterialPageRoute(builder: (context) =>  CAt()));
//               },
//               child: const ListTile(
//                 leading: Icon(Icons.new_label),
//                 title: Text('test'),
//               )),
//           InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const ShippingAddress()));
//             },
//             child: const ListTile(
//                 leading: Icon(Icons.location_on_sharp),
//                 title: Text('Shipping addresses')),
//           ),
//           BlocListener<HomeBloc, HomeState>(
//             listener: (context, state) {
//               if (state is LoggedOutSuccessState) {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Leaving us?'),
//                       content: const Text('Are you sure?  Do you want to Logout?'),
//                       actions: [
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('No',
//                                 style: TextStyle(color: Colors.grey.shade800))),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LogInPage()),
//                                 (route) => false,
//                               );
//                             },
//                             child: const Text(
//                               'Yes',
//                               style: TextStyle(color: Colors.red),
//                             )),
//                       ],
//                     );
//                   },
//                 );
//               }
//             },
//             child: InkWell(
//               onTap: () {
//                 context.read<HomeBloc>().add(OnLogoutEvent());
//               },
//               child: const ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text('Logout'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
