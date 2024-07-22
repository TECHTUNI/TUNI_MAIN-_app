import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuni/presentation/pages/profile/profile/user_profile_refactor.dart';
import 'package:tuni/presentation/pages/splash_screen/welcom.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final User? user = FirebaseAuth.instance.currentUser;
  DateTime? date;
  String dobButtonText = "Select Date of Birth";

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController refferalcode = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userId = user!.uid;
    final docSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("personal_details")
        .doc("details")
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>? ?? {};
      final fetchedDate = data["dob"] ?? "Add DOB";

      setState(() {
        dobButtonText = fetchedDate;
        date = fetchedDate != "Add DOB" ? parseDate(fetchedDate) : null;
        firstNameController.text = data["first_name"] ?? "";
        lastNameController.text = data["last_name"] ?? "";
        mobileNumberController.text = data["mobileNumber"] ?? "";
        emailController.text = data["email"] ?? "";
        refferalcode.text = data["referralCode"] ?? "";
      });
    }
  }

  DateTime parseDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid date format', dateStr);
    }
    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(
                      "Assets/logo/userprofileicon.png",
                      height: 80,
                      width: 80,
                    ),
                    Text("Hey ${firstNameController.text}",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const UserProfileHeadings(text: "Personal Details"),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserProfileTextFields(
                      controller: firstNameController,
                      placeHolder: "First Name",
                    ),
                    const SizedBox(height: 10),
                    UserProfileTextFields(
                      controller: lastNameController,
                      placeHolder: "Last Name",
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => _showDatePicker(context),
                          child: Text(
                            dobButtonText,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const UserProfileHeadings(text: "Contact Details"),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    UserProfileTextFields(
                      controller: mobileNumberController,
                      placeHolder: "Mobile Number",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    UserProfileTextFields(
                      controller: emailController,
                      placeHolder: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _updateDetails();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    _deleteAccount();
                  },
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          date ?? DateTime.now().subtract(const Duration(days: 365 * 16)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        dobButtonText = '${picked.month}-${picked.day}-${picked.year}';
      });
    }
  }

  void _updateDetails() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        dobButtonText != "Select Date of Birth" &&
        mobileNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      if (mobileNumberController.text.length == 10) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .collection("personal_details")
            .doc("details")
            .set({
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
          "dob": dobButtonText,
          "email": emailController.text.trim(),
          "mobileNumber": mobileNumberController.text.trim(),
          "referralCode": refferalcode.text.trim(),
        }).then((value) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Details Updated Successfully'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Mobile Number should be 10 digits"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Please fill all details properly"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteAccount() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(),
      ),
      (route) => false,
    );
    FirebaseAuth.instance.currentUser?.delete();
  }
}

class UserProfileTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;
  final TextInputType keyboardType;

  const UserProfileTextFields({
    required this.controller,
    required this.placeHolder,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: placeHolder,
      ),
    );
  }
}

class UserProfileHeadings extends StatelessWidget {
  final String text;

  const UserProfileHeadings({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
