// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:share_plus/share_plus.dart';

// class RefferalPage extends StatelessWidget {
//   const RefferalPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Refer Your Friend'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 119, 86, 37),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Icon(Icons.currency_rupee_outlined, color: Colors.white),
//                       SizedBox(width: 10),
//                       Text(
//                         'Your Earnings:',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       Spacer(),
//                       Text(
//                         '₹250',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Invite your friends and earn more rewards. Share the referral link below:',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             FirebaseAuth.instance.currentUser!.uid,
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 12),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.share, color: Colors.black),
//                           onPressed: () {
//                             // Add your sharing functionality here
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.copy, color: Colors.black),
//                           onPressed: () {
//                             Clipboard.setData(
//                               const ClipboardData(
//                                   text: 'https://yourapp.com/referral'),
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       'Referral link copied to clipboard!')),
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         _showWithdrawDialog(context);
//                       },
//                       icon: const Icon(Icons.account_balance_wallet),
//                       label: const Text('Withdraw Earnings'),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'How it works:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     RichText(
//                       text: const TextSpan(
//                         style: TextStyle(color: Colors.black),
//                         children: [
//                           TextSpan(
//                               text:
//                                   '1. Share your referral code with friends.\n'),
//                           TextSpan(
//                               text:
//                                   '2. apply the code while ordering the combo product.\n'),
//                           TextSpan(
//                             text:
//                                 '3. Once someone places an order using your code,    you will get 10% of the order amount. This offer is only applicable for ',
//                           ),
//                           TextSpan(
//                             text: 'Combo Products',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           TextSpan(text: '.'),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     Center(
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Share.share(
//                               'Check out this app: https://yourapp.com/referral');
//                         },
//                         icon: const Icon(Icons.share),
//                         label: const Text('Share Referral Link'),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showWithdrawDialog(BuildContext context) {
//     final TextEditingController amountController = TextEditingController();
//     final TextEditingController upiController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Withdraw Earnings'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: amountController,
//                 decoration:
//                     const InputDecoration(labelText: 'Withdrawal Amount'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: upiController,
//                 decoration: const InputDecoration(labelText: 'UPI ID'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
// ElevatedButton(
//   child: const Text('Withdraw'),
//   onPressed: () {
//     String amount = amountController.text;
//     String upiId = upiController.text;
//     // Add your withdrawal functionality here
//     Navigator.of(context).pop();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//           content: Text(
//               'Withdrawal request submitted for \$${amount} to UPI ID: ${upiId}')),
//     );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RefferalPage extends StatefulWidget {
  const RefferalPage({Key? key}) : super(key: key);

  @override
  _RefferalPageState createState() => _RefferalPageState();
}

class _RefferalPageState extends State<RefferalPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController upiNameController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer Your Friend'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 119, 86, 37),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.money, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Your Earnings:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '₹250',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Invite your friends and earn more rewards. Share the referral link below:',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'https://yourapp.com/referral',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.black),
                          onPressed: () {
                            Share.share(
                                'Check out this app: https://yourapp.com/referral');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(
                                  text: 'https://yourapp.com/referral'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Referral link copied to clipboard!')),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showWithdrawDialog(context);
                      },
                      icon: const Icon(Icons.account_balance_wallet),
                      label: const Text('Withdraw Earnings'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How it works:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  '1. Share your referral code with friends.\n'),
                          TextSpan(
                              text:
                                  '2. Apply the code while ordering the combo product.\n'),
                          TextSpan(
                            text:
                                '3. Once someone places an order using your code, you will get 10% of the order amount. This offer is only applicable for ',
                          ),
                          TextSpan(
                            text: 'Combo Products',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Share.share(
                              'Check out this app: https://yourapp.com/referral');
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share Referral Link'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Withdraw Earnings'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    decoration:
                        const InputDecoration(labelText: 'Withdrawal Amount'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: upiController,
                    decoration: const InputDecoration(labelText: 'UPI ID'),
                  ),
                  TextField(
                    controller: upiNameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'UPI Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Withdraw'),
                  onPressed: () {
                    _withdrawAmount();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _withdrawAmount() async {
    String amountText = amountController.text.trim();
    String upiId = upiController.text.trim();

    if (amountText.isEmpty || upiId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter amount and UPI ID')),
      );
      return;
    }

    double amount = double.parse(amountText);

    try {
      // Validate UPI ID (simulate validation)
      bool isUPIValid = await _simulateUPIValidation(upiId);

      if (!isUPIValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid UPI ID')),
        );
        return;
      }

      // Deduct the amount from user's earnings (simulate deduction)
      bool isAmountDeducted = await _deductAmountFromEarnings(amount);

      if (isAmountDeducted) {
        // Add withdrawal request to Firestore
        await _addWithdrawalRequest(amount, upiId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Withdrawal request submitted for ₹$amount to UPI ID: $upiId'),
          ),
        );
        Navigator.of(context).pop(); // Close dialog after successful withdrawal
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient earnings')),
        );
      }
    } catch (e) {
      print('Error withdrawing amount: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to withdraw amount')),
      );
    }
  }

  Future<bool> _simulateUPIValidation(String upiId) async {
    // Simulate UPI ID validation (replace with actual logic)
    // For demonstration, check if the UPI ID starts with 'receiver'
    if (upiId.startsWith(upiId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _deductAmountFromEarnings(double amount) async {
    // Simulate deduction from earnings (replace with actual logic)
    // For demonstration, assume the amount is always deducted successfully
    return true;
  }

  Future<void> _addWithdrawalRequest(double amount, String upiId) async {
    // Add withdrawal request to Firestore
    try {
      CollectionReference withdrawals = firestore.collection('withdrawals');

      await withdrawals.add({
        'userId': 'current_user_id', // Replace with actual user ID
        'amount': amount,
        'upiId': upiId,
        'status': 'pending',
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print('Error adding withdrawal request: $e');
      throw Exception('Failed to add withdrawal request');
    }
  }
}
