import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuni/presentation/pages/splash_screen/welcom.dart';

class AndroidAnonymousUserProfilePage extends StatelessWidget {
  const AndroidAnonymousUserProfilePage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container for Image and Text Below Image
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Column(
                  children: [
                    // Welcome Text
                    const Text(
                      'Welcome to Tuni',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    // Image
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Image.asset(
                        'Assets/login_girl.jpg', // Replace with your image path
                        height: screenHeight * 0.3, // Adjust height as needed
                        width: screenWidth, // Full width of the screen
                        fit: BoxFit.cover, // Adjust fit as needed
                      ),
                    ),
                    // Text below the image
                    const Text(
                      'Join us and explore a world of exciting features!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Container for Menu Options and Login Button
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // Adjust radius here
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Menu Options
                    _buildMenuItem(context, Icons.shopping_cart, 'Orders'),
                    _buildMenuItem(context, Icons.support_agent, 'Customer Support'),
                    _buildMenuItem(context, Icons.favorite_border, 'Wishlist'),
                    SizedBox(height: screenHeight * 0.03),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser?.delete().then((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ),
                            (route) => false,
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error deleting user: $error'),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust radius here
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        if (FirebaseAuth.instance.currentUser == null) {
          // User is not logged in, show a dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Required'),
                content: const Text('Please log in to access this feature.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // User is logged in, handle navigation or action here
        }
      },
    );
  }
}
