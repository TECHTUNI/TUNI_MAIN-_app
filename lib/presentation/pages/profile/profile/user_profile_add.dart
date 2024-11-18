import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuni/presentation/pages/profile/profile/user_profile_refactor.dart';

import '../../../bloc/user_profile_bloc/user_profile_bloc.dart';

class UserProfileAdd extends StatefulWidget {
  const UserProfileAdd({super.key});

  @override
  State<UserProfileAdd> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileAdd> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final items = ["select a value", "MEN", "WOMEN"];
  String? gender;
  var dd;
  var mm;
  var yyyy;
  User user = FirebaseAuth.instance.currentUser!;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    gender = items[0];
    selectedDate = DateTime.now().subtract(const Duration(days: 16 * 365));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
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
                        const SizedBox(height: 30),
                        SizedBox(
                          width: screenWidth * .5,
                          height: 45,
                          child:
                              BlocListener<UserProfileBloc, UserProfileState>(
                            listener: (context, state) {
                              if (state is UserDetailAddedState) {
                                Navigator.pop(context);
                              }
                            },
                            child: ElevatedButton(
                              onPressed: () {
                                if (validateInputsforEditprofile([
                                  firstNameController,
                                  mobileNumberController,
                                  lastNameController
                                ], context)) {
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
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("Add details"),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("Add Your Details"),
            ),
            child: Padding(
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
                  CupertinoButton.filled(
                    child: const Text("Add"),
                    onPressed: () {
                      if (firstNameController.text.isNotEmpty &&
                              mobileNumberController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty
                          // selectedDate.day != null &&
                          // selectedDate.month != null &&
                          // selectedDate.year != null
                          ) {
                        context
                            .read<UserProfileBloc>()
                            .add(OnAddUserDetailsEvent(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              number: mobileNumberController.text,
                              // gender: gender!,
                              // day: selectedDate.day,
                              // month: selectedDate.month,
                              // year: selectedDate.year
                            ));
                      } else {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                  "Please add your details properly"),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"))
                              ],
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    gender = null;
    dd = null;
    mm = null;
    yyyy = null;
    super.dispose();
  }

  SizedBox buildSizedBox() => const SizedBox(height: 15);
}

class CupertinoDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  const CupertinoDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  _CupertinoDropdownButtonState<T> createState() =>
      _CupertinoDropdownButtonState<T>();
}

class _CupertinoDropdownButtonState<T>
    extends State<CupertinoDropdownButton<T>> {
  @override
  void initState() {
    super.initState();
    // _selectedIndex = widget.items.indexOf(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: 0),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    widget.onChanged(widget.items[index]);
                  });
                },
                children: List<Widget>.generate(
                  widget.items.length,
                  (int index) {
                    return Center(
                      child: Text(
                        widget.items[index].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.secondarySystemBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""
                // widget.items[_selectedIndex].toString(),
                // style: const TextStyle(fontSize: 18),
                ),
            Icon(
              CupertinoIcons.chevron_down,
              size: 24,
              color: CupertinoColors.activeBlue,
            ),
          ],
        ),
      ),
    );
  }
}

bool validateInputsforEditprofile(List<TextEditingController> controllers,
    [BuildContext? context]) {
  // Regular expression for letters only
  RegExp lettersOnly = RegExp(r'^[a-zA-Z]+$');

  // Check if any field is empty
  for (var controller in controllers) {
    if (controller.text.isEmpty) {
      _showErrorDialog(context, 'Please fill in all fields.');
      return false;
    }
  }

  // Check if first name contains only letters
  if (!lettersOnly.hasMatch(controllers[0].text)) {
    _showErrorDialog(context, 'First name must contain only letters.');
    return false;
  }

  // Check if last name contains only letters
  if (!lettersOnly.hasMatch(controllers[1].text)) {
    _showErrorDialog(context, 'Last name must contain only letters.');
    return false;
  }

  // Check mobile number length and if it contains only digits
  if (controllers[2].text.length != 10 || !isNumeric(controllers[2].text)) {
    _showErrorDialog(context, 'Mobile number must be exactly 10 digits.');
    return false;
  }

  return true;
}

bool isNumeric(String? str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
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
