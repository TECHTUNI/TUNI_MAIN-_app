import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuni/core/provider/refferal_provider.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({super.key});

  @override
  ReferralPageState createState() => ReferralPageState();
}

class ReferralPageState extends State<ReferralPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController upiNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final referralProvider =
        Provider.of<ReferralProvider>(context, listen: false);
    referralProvider.fetchReferralData();
  }

  @override
  Widget build(BuildContext context) {
    final referralProvider = Provider.of<ReferralProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Refer Your Friend & Earn',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
        elevation: 0, // This removes the shadow border
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.red,
                      Colors.black,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: referralProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Your Earnings:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '₹ ${referralProvider.rewardAmount}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Invite your friends and earn more rewards. Share the referral link below:',
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            referralProvider.referralCode ??
                                                "Loading...",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy,
                                              color: Colors.black),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text: referralProvider
                                                      .referralCode!),
                                            ).then((value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Referral Code Copied to clipboard"),
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.purple, // background
                                        foregroundColor:
                                            Colors.white, // foreground
                                      ),
                                      onPressed: () {
                                        _showWithdrawDialog(context);
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.account_balance_wallet),
                                          SizedBox(width: 20),
                                          Text('Withdraw Earnings')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      bool isUPIValid = await _simulateUPIValidation(upiId);

      if (!isUPIValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid UPI ID')),
        );
        return;
      }

      bool isAmountDeducted = await _deductAmountFromEarnings(amount);

      if (isAmountDeducted) {
        await _addWithdrawalRequest(amount, upiId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Withdrawal request submitted for ₹$amount to UPI ID: $upiId'),
          ),
        );
        Navigator.of(context).pop();
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
    if (upiId.startsWith(upiId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _deductAmountFromEarnings(double amount) async {
    return true;
  }

  Future<void> _addWithdrawalRequest(double amount, String upiId) async {
    try {
      CollectionReference withdrawals =
          FirebaseFirestore.instance.collection('withdrawals');

      await withdrawals.add({
        'userId': 'current_user_id',
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
