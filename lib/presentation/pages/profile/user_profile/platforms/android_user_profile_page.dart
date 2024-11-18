// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tuni/presentation/pages/refferal_page/reffaral.dart';
// import 'package:tuni/presentation/pages/splash_screen/welcom.dart';
import 'package:tuni/presentation/pages/auth/sign_up/refactor.dart';
import 'package:tuni/presentation/pages/profile/user_profile/platforms/profile_widget.dart';
import 'package:tuni/presentation/pages/refferal_page/reffaral.dart';
import 'package:tuni/presentation/pages/splash_screen/welcom.dart';

import '../../Favorites/favorite_page.dart';
import '../../my_orders/user_orders.dart';
import '../../profile/user_profile.dart';
import '../../shipping_address/shipping_address.dart';

// class AndroidUserProfilePage extends StatelessWidget {
//   const AndroidUserProfilePage({
//     super.key,
//     required this.userId,
//     required this.userEmail,
//     required this.screenWidth,
//   });

//   final String userId;
//   final String userEmail;
//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("PROFILE"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: ListView(
//             children: [
//               StreamBuilder<DocumentSnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("users")
//                       .doc(userId)
//                       .collection("personal_details")
//                       .doc('details')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Text("Error: ${snapshot.error}");
//                     }
//                     if (!snapshot.hasData || !snapshot.data!.exists) {
//                       return const Text(" ");
//                     }
//                     String name = "";
//                     String? initials;

//                     if (snapshot.hasData && snapshot.data!.exists) {
//                       var data = snapshot.data!.data() as Map<String, dynamic>;
//                       name =
//                           "${data["first_name"] ?? ""} ${data["last_name"] ?? ""}";
//                       String? firstName = data["first_name"];
//                       String? lastName = data["last_name"];

//                       initials =
//                           "${firstName?.isNotEmpty == true ? firstName![0] : ""}${lastName?.isNotEmpty == true ? lastName![0] : ""}";
//                     }
//                     return Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.black,
//                           radius: screenWidth * .1,
//                           child: RichText(
//                             text: TextSpan(children: [
//                               TextSpan(
//                                   text: initials ?? "",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: screenWidth * .07)),
//                               // TextSpan(text: ""),
//                             ]),
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         SizedBox(
//                           height: 60,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   name,
//                                   style: TextStyle(
//                                       fontSize: screenWidth * .05,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 2),
//                                 ),
//                                 Text(
//                                   userEmail,
//                                   style: TextStyle(
//                                       fontSize: screenWidth * .04,
//                                       letterSpacing: 1),
//                                 ),
//                               ]),
//                         )
//                       ],
//                     );
//                   }),
//               const SizedBox(height: 20),
//               ListTile(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UserProfile()));
//                 },
//                 leading: const Icon(
//                   Icons.person,
//                   size: 20,
//                 ),
//                 title: const Text("Profile Details"),
//                 trailing: const Icon(
//                   Icons.chevron_right,
//                   size: 15,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ReferralPage()));
//                 },
//                 leading: const Icon(
//                   Icons.currency_rupee,
//                   size: 22,
//                 ),
//                 title: const Text("Reffer and earn"),
//                 trailing: const Icon(
//                   Icons.chevron_right,
//                   size: 15,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => UserOrders()));
//                 },
//                 leading: const Icon(
//                   Icons.shopping_cart,
//                   size: 20,
//                 ),
//                 title: const Text("Order History"),
//                 trailing: const Icon(
//                   Icons.chevron_right,
//                   size: 15,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => FavoritePage()));
//                 },
//                 leading: const Icon(
//                   Icons.favorite_border,
//                   size: 20,
//                 ),
//                 title: const Text("Favorites"),
//                 trailing: const Icon(
//                   Icons.chevron_right,
//                   size: 15,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ShippingAddress(),
//                       ));
//                 },
//                 leading: const Icon(
//                   Icons.navigation_outlined,
//                   size: 20,
//                 ),
//                 title: const Text("Address Book"),
//                 trailing: const Icon(
//                   Icons.chevron_right,
//                   size: 15,
//                 ),
//               ),
//               BlocListener<HomeBloc, HomeState>(
//                 listener: (context, state) {
//                   if (state is LoggedOutSuccessState) {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text("You'll be missed!"),
//                           content: const Text(
//                               'Are you sure?  Do you want to Logout?'),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("No")),
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const WelcomePage(),
//                                     ),
//                                     (route) => false,
//                                   );
//                                 },
//                                 child: const Text("Logout",
//                                     style: TextStyle(color: Colors.red))),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//                 child: ListTile(
//                   onTap: () {
//                     context.read<HomeBloc>().add(OnLogoutEvent());
//                   },
//                   leading: const Icon(
//                     Icons.logout,
//                     size: 20,
//                     color: Colors.red,
//                   ),
//                   title: const Text(
//                     "Logout",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   trailing: const Icon(
//                     Icons.chevron_right,
//                     size: 15,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 child: const Text(
//                   "Delete Account",
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text("Leaving us?"),
//                         content: const Text(
//                             "Are you sure you want to delete your account?"),
//                         actions: [
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text("No")),
//                           TextButton(
//                               onPressed: () {
//                                 // Navigator.pushAndRemoveUntil(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //       builder: (context) => LogInPage(),
//                                 //     ),
//                                 //     (route) => false);
//                                 context
//                                     .read<HomeBloc>()
//                                     .add(OnDeleteUserEvent());
//                               },
//                               child: const Text(
//                                 "Delete",
//                                 style: TextStyle(color: Colors.red),
//                               )),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/refferal_provider.dart';
import 'package:tuni/main.dart';

class AndroidUserProfilePage extends StatefulWidget {
  const AndroidUserProfilePage({
    super.key,
    required this.userId,
    required this.userEmail,
    required this.screenWidth,
  });

  final String? userId;
  final String userEmail;
  final double screenWidth;

  @override
  State<AndroidUserProfilePage> createState() => _AndroidUserProfilePagestate();
}

class _AndroidUserProfilePagestate extends State<AndroidUserProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    main();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docSnapshot = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("personal_details")
        .doc("details")
        .snapshots();

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PROFILE"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot>(
                  stream: docSnapshot,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.data?.data() as Map<String, dynamic>?;

                    final String firstName = data?["first_name"] ?? "User";
                    final String lastName = data?["last_name"] ?? "Name";
                    final String email = data?["email"] ?? "tuniuser@gmail.com";
                    final String mobileNumber =
                        data?["mobileNumber"] ?? "9876543210";

                    final shortName =
                        firstName.substring(0, 1) + lastName.substring(0, 1);

                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  shortName.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$firstName $lastName",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(email),
                                Text(mobileNumber),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Consumer<ReferralProvider>(
                  builder: (context, referralProvider, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: screenWidth * .46,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.purple[50],
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Total Withdrawn"),
                                  Text(
                                    referralProvider.rewardAmount == 0
                                        ? "0"
                                        : referralProvider.rewardAmount
                                            .toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 100,
                              width: screenWidth * .46,
                              decoration: BoxDecoration(
                                  color: Colors.purple[50],
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("pending"),
                                  Text(
                                    "₹1000",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                            ),
                          ],
                        ),
                        sizedBox(height: 10),
                        Container(
                          height: 100,
                          width: screenWidth * 1,
                          decoration: BoxDecoration(
                              color: Colors.purple[50],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Earnings"),
                              Text(
                                "₹1000",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const ProfilePageLists(
                          className: UserProfile(),
                          icon: Icons.person,
                          text: "Profile Details"),
                      const SizedBox(height: 8),
                      ProfilePageLists(
                          className: UserOrders(),
                          icon: Icons.list,
                          text: "Order History"),
                      const SizedBox(height: 8),
                      ProfilePageLists(
                          className: FavoritePage(),
                          icon: Icons.favorite,
                          text: "Favorites"),
                      const SizedBox(height: 8),
                      const ProfilePageLists(
                          className: ShippingAddress(),
                          icon: Icons.location_on,
                          text: "Address Book"),
                      const SizedBox(height: 8),
                      const ProfilePageLists(
                          className: ReferralPage(),
                          icon: Icons.supervisor_account,
                          text: "Refer and Earn"),
                      const SizedBox(height: 8),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("You'll be missed!"),
                                content: const Text(
                                    'Are you sure? Do you want to Logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomePage(),
                                          ),
                                          (route) => false,
                                        );
                                        FirebaseAuth.instance.signOut();
                                      },
                                      child: const Text("Logout",
                                          style: TextStyle(color: Colors.red))),
                                ],
                              );
                            },
                          );
                        },
                        leading: const Icon(
                          Icons.logout,
                          size: 18,
                          color: Colors.red,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          size: 15,
                          color: Colors.red,
                        ),
                      ),
                    ],
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
