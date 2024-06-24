String? validateEmail(String? email) {
  // Regular expression for validating email
  final RegExp regex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  if (email == null || email.isEmpty) {
    return 'Please enter an email';
  } else if (!regex.hasMatch(email)) {
    return 'Please enter a valid email';
  }

  return null; // Return null if email is valid
}

// Future<bool> sendEmail({required String name, required String senderEmail}) async {
//   try {
//     dynamic tempalate = 'hiiiiiiiiiiiiii';
//     await EmailJS.send(
//       'service_lv8pkvl',
//       'template_k9te8fc',
//       tempalate,
//       const Options(
//         publicKey: 'ezkCbhcGWzODm9srh',
//         privateKey: 'hJZTz9RNCr_6Pce6JkxcB',
//       ),
//     );
//     print('SUCCESS!');
//     return true;
//   } catch (error) {
//     if (error is EmailJSResponseStatus) {
//       print('ERROR... ${error.status}: ${error.text}');
//     }
//     print(error.toString());
//     return false;
//   }
// }

// Future<void> sendEmail(
// //     {required String name, required String senderEmail}) async {
// //   Map<String, dynamic> templateParams = {
// //     'name': name,
// //     'sender_email': senderEmail,
// //     'notes': 'Please login to your account!'
// //   };

// //   try {
// //     await EmailJS.send(
// //       'service_lv8pkvl',
// //       'template_k9te8fc',
// //       templateParams,
// //       const Options(
// //         publicKey: 'I8Tx-vUkd08MNAZFM',
// //         privateKey: 'OTH8FrAOitWQOOAMBErCd',
// //       ),
// //     );
// //     print('SUCCESS!');
// //   } catch (error) {
// //     print('Error sending email: $error');
// //   }

// }

