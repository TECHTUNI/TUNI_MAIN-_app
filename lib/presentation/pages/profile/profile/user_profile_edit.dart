import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuni/presentation/pages/profile/profile/user_profile_add.dart';

import '../../../bloc/user_profile_bloc/user_profile_bloc.dart';
import 'user_profile_refactor.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({super.key});

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController mobileNumberController;

  final items = ["select a value", "MEN", "WOMEN"];
  String? gender;
  var dd;
  var mm;
  var yyyy;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    gender = items[0];
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final userId = user.uid;
    final firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("personal_details")
        .doc('personal_details')
        .snapshots();

    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: const Text(
                'EDIT PROFILE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: firestore,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // return Center(
                          //   child: CircularProgressIndicator(),
                          // );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        final DocumentSnapshot<Object?>? snapshotData =
                            snapshot.data;
                        if (snapshotData != null) {
                          final DocumentSnapshot<Object?> data = snapshotData;
                          // final Map<String, dynamic>? dateMap =
                          //     snapshotData["date"];
                          firstNameController.text = data["first_name"];
                          lastNameController.text = data["last_name"];
                          mobileNumberController.text = data["phone_number"];
                          // gender = data["gender"];
                          // dd = dateMap?["day"];
                          // mm = dateMap?["month"];
                          // yyyy = dateMap?["year"];
                        } else {}

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            UserProfileTextFormField(
                              text: "First Name",
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                            ),
                            buildSizedBox(),
                            UserProfileTextFormField(
                              text: "Last Name",
                              controller: lastNameController,
                              keyboardType: TextInputType.text,
                            ),
                            buildSizedBox(),
                            UserProfileTextFormField(
                              text: "Mobile Number",
                              controller: mobileNumberController,
                              keyboardType: TextInputType.phone,
                            ),
                            buildSizedBox(),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: screenWidth * .5,
                              height: 45,
                              child: BlocListener<UserProfileBloc,
                                  UserProfileState>(
                                listener: (context, state) {
                                  if (state is UserDetailAddedState) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: ElevatedButton(
                                  onPressed: () {
                                    final validation =
                                        validateInputsforEditprofile([
                                      firstNameController,
                                      lastNameController,
                                      mobileNumberController
                                    ], context);
                                    if (validation == true) {
                                      context
                                          .read<UserProfileBloc>()
                                          .add(OnAddUserDetailsEvent(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            number: mobileNumberController.text,
                                            // gender: gender!,
                                            // day: dd,
                                            // month: mm,
                                            // year: yyyy
                                          ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text("Add details"),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("EDIT PROFILE"),
            ),
            child: StreamBuilder<DocumentSnapshot>(
                stream: firestore,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  final DocumentSnapshot<Object?>? snapshotData = snapshot.data;
                  if (snapshotData != null) {
                    final DocumentSnapshot<Object?> data = snapshotData;
                    // final Map<String, dynamic>? dateMap = snapshotData["date"];
                    firstNameController.text = data["first_name"];
                    lastNameController.text = data["last_name"];
                    mobileNumberController.text = data["phone_number"];
                    // gender = data["gender"];
                    // dd = dateMap?["day"];
                    // mm = dateMap?["month"];
                    // yyyy = dateMap?["year"];
                  } else {}

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 40,
                          child: CupertinoTextField(
                            controller: firstNameController,
                            placeholder: "First Name",
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 40,
                          child: CupertinoTextField(
                            controller: lastNameController,
                            placeholder: "Last Name",
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 40,
                          child: CupertinoTextField(
                            controller: mobileNumberController,
                            placeholder: "Phone number",
                          ),
                        ),
                        const SizedBox(height: 15),
                        CupertinoButton(
                            child: const Text("Update"),
                            onPressed: () {
                              if (firstNameController.text.isNotEmpty &&
                                      mobileNumberController.text.isNotEmpty &&
                                      lastNameController.text.isNotEmpty
                                  // &&
                                  // gender != "select a value" &&
                                  // dd != null &&
                                  // mm != null &&
                                  // yyyy != null
                                  ) {
                                context
                                    .read<UserProfileBloc>()
                                    .add(OnAddUserDetailsEvent(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      number: mobileNumberController.text,
                                      // gender: gender!,
                                      // day: dd,
                                      // month: mm,
                                      // year: yyyy
                                    ));
                              }
                            })
                      ],
                    ),
                  );
                }));
  }

  SizedBox buildSizedBox() => const SizedBox(height: 15);
}
