import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tuni/core/model/cart_model.dart';

import '../../../../../../core/model/product_order_model.dart';
import '../../profile/shipping_address/address_refactor.dart';
import 'checkout_page.dart';

class SelectAddress extends StatefulWidget {
  final List<CartItemModel> orderList;
  final int total;
  final List<String> ids;

  const SelectAddress(
      {super.key,
      required this.orderList,
      required this.total,
      required this.ids});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  void dispose() {
    // TODO: implement dispose
    SelectAddress(
      orderList: widget.orderList,
      total: widget.total,
      ids: widget.ids,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String userId = user!.uid;
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address')
        .snapshots();

    Map<String, dynamic> address = {};

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController1 = TextEditingController();
    final TextEditingController addressController2 = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController pinCodeController = TextEditingController();
    String selected_adress = '';

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text(
            'Your Address',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return addNewAddress(
                          context: context,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          nameController: nameController,
                          phoneNumberController: phoneNumberController,
                          adressLineController1: addressController1,
                          adressLineController2: addressController2,
                          StateController: stateController,
                          cityController: cityController,
                          pincodeController: pinCodeController,
                        );
                      });
                },
                child: const Text('New Address'))
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String addressId = snapshot.data!.docs[index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) async {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('address')
                                        .doc(addressId)
                                        .delete();
                                    if (addressId == selected_adress) {
                                      address.clear();
                                    }
                                  },
                                  icon: Icons.delete,
                                  label: 'delete',
                                ),
                                SlidableAction(
                                  onPressed: (_) async {
                                    Widget dialogContent = await editAddress(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      context: context,
                                      nameController: nameController,
                                      phoneNumberController:
                                          phoneNumberController,
                                      adressLineController1: addressController1,
                                      adressLineController2: addressController2,
                                      StateController: stateController,
                                      cityController: cityController,
                                      pincodeController: pinCodeController,
                                      id: addressId,
                                    );
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialogContent;
                                      },
                                    );
                                  },
                                  icon: Icons.edit,
                                  label: 'edit',
                                ),
                              ]),
                          child: InkWell(
                            onTap: () {
                              address = {
                                "Name": snapshot.data!.docs[index]['Name'],
                                "phone_number": snapshot.data!.docs[index]
                                    ['phone_number'],
                                "city": snapshot.data!.docs[index]['city'],
                                "address": snapshot.data!.docs[index]
                                    ['address'],
                                "address1": snapshot.data!.docs[index]
                                    ['address1'],
                                "state": snapshot.data!.docs[index]['state'],
                                "pincode": snapshot.data!.docs[index]
                                    ['pincode'],
                              };
                              selected_adress =
                                  snapshot.data!.docs[index]['id'];

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Address Selected $address')));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadowColor: Colors.white,
                              child:
                                  //  ListTile(
                                  //   leading: Text(
                                  //     '${index + 1}',
                                  //     style: const TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w400),
                                  //   ),
                                  //   title: Text(
                                  //     snapshot.data!.docs[index]['houseName']
                                  //         .toString()
                                  //         .toUpperCase(),
                                  //     style: const TextStyle(
                                  //         color: Colors.black,
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.bold,
                                  //         letterSpacing: 1.5),
                                  //   ),
                                  //   subtitle: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       const SizedBox(height: 5),
                                  //       RichText(
                                  //           text: TextSpan(
                                  //               text: snapshot
                                  //                   .data!.docs[index]['city']
                                  //                   .toString()
                                  //                   .toUpperCase(),
                                  //               style: const TextStyle(
                                  //                   color: Colors.black,
                                  //                   letterSpacing: 1),
                                  //               children: [
                                  //             const TextSpan(
                                  //               text: ', ',
                                  //             ),
                                  //             TextSpan(
                                  //               text: snapshot
                                  //                   .data!.docs[index]['landmark']
                                  //                   .toString(),
                                  //             )
                                  //           ])),
                                  //       const SizedBox(height: 5),
                                  //       Text(snapshot.data!.docs[index]['pincode']
                                  //           .toString()),
                                  //       const SizedBox(height: 5),
                                  //     ],
                                  //   ),
                                  // ),
                                  ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['Name']
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot
                                        .data!.docs[index]['phone_number']
                                        .toString()), // Adding phone number here
                                    const SizedBox(height: 5),
                                    Text(snapshot.data!.docs[index]['address']
                                        .toString()),
                                    const SizedBox(height: 5),
                                    Text(snapshot.data!.docs[index]['address1']
                                        .toString()),
                                    const SizedBox(height: 5),

                                    RichText(
                                      text: TextSpan(
                                        text: snapshot.data!.docs[index]['city']
                                            .toString()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: ', ',
                                          ),
                                          TextSpan(
                                            text: snapshot
                                                .data!.docs[index]['state']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(snapshot.data!.docs[index]['pincode']
                                        .toString()),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Delete Address'),
                                          content: const Text(
                                              'Are you sure you want to delete this address?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userId)
                                                    .collection('address')
                                                    .doc(addressId)
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      if (address.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOutFromCartPage(
                                address: address,
                                orderList: widget.orderList,
                                total: widget.total,
                                ids: widget.ids,
                              ),
                            ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          'Select an address',
                          style: TextStyle(color: Colors.red),
                        )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text("PAY"))),
          ),
        ));
  }

  TextStyle styles() {
    return const TextStyle(color: CupertinoColors.black, fontSize: 15);
  }

  TextStyle addressStyles() {
    return const TextStyle(
        color: CupertinoColors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold);
  }

  Widget _buildAddressRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: styles(),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: addressStyles(),
          ),
        ),
      ],
    );
  }
}
