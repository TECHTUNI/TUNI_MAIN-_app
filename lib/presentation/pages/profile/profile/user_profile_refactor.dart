import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfileTextFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const UserProfileTextFormField({
    super.key,
    required this.text,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters;

    // Determine input formatters based on the field type
    if (text == "First Name" || text == "Last Name") {
      inputFormatters = firstNameLastNameInputFormatters;
    } else if (text == "Mobile Number") {
      inputFormatters = phoneNumberInputFormatters;
    }

    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: text,
          filled: true,
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Input formatters
  static List<TextInputFormatter> firstNameLastNameInputFormatters = [
    FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z\s]')), // Allow letters and spaces
  ];

  static List<TextInputFormatter> phoneNumberInputFormatters = [
    FilteringTextInputFormatter.digitsOnly, // Allow digits only
  ];
}

class UserProfileElevatedButton extends StatelessWidget {
  const UserProfileElevatedButton({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .5,
      height: 45,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text("Add details"),
      ),
    );
  }
}

Text userDetailsDisplayingText(dynamic text) {
  return Text(
    text.toString(),
    style: const TextStyle(
        fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.w500),
  );
}

Text userDetailsHeadingText({required String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      letterSpacing: 2,
    ),
  );
}
