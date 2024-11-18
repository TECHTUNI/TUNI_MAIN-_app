import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class checkInternetConnectivity extends StatefulWidget {
  const checkInternetConnectivity({super.key});

  @override
  State<checkInternetConnectivity> createState() =>
      _checkInternetConnectivityState();
}

class _checkInternetConnectivityState extends State<checkInternetConnectivity> {
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return isConnected
        ? _buildUI(context, screenWidth, screenHeight)
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/logo/Tuni logo.png",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sorry! Connection is lost',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please make sure you have good network',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    ' And try again',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      checkInternetConnectivity();
                    },
                    child: const Text(
                      'Retry',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildUI(
      BuildContext context, double screenWidth, double screenHeight) {
    return const Placeholder();
  }
}
