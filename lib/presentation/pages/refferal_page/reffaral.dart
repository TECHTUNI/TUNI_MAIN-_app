import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class RefferalPage extends StatelessWidget {
  const RefferalPage({super.key});

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
                      Icon(Icons.currency_rupee_outlined, color: Colors.white),
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
                        Expanded(
                          child: Text(
                            FirebaseAuth.instance.currentUser!.uid,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.black),
                          onPressed: () {
                            // Add your sharing functionality here
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
                                  '2. apply the code while ordering the combo product.\n'),
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
    final TextEditingController amountController = TextEditingController();
    final TextEditingController upiController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                String amount = amountController.text;
                String upiId = upiController.text;
                // Add your withdrawal functionality here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Withdrawal request submitted for \$${amount} to UPI ID: ${upiId}')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
