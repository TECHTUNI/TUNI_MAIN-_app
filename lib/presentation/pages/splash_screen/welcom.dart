import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/google_signin_provider.dart';
import 'package:tuni/core/provider/login_provider.dart';
import 'package:tuni/core/provider/refferal_provider.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';
import 'package:video_player/video_player.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  List<String> videoPaths = [
    // "https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2Ftuni_ios_thumbnail_video.mp4?alt=media&token=c7c05c6c-f879-4280-89d1-4966835bfe4f"

    "https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2F_1717588086532?alt=media&token=8dcc0bd1-ebc9-460e-a522-d882f12e7c63"
  ];

  late List<VideoPlayerController> _videoControllers;
  late List<ChewieController> _chewieControllers;
  late CarouselController _carouselController;
  int _currentPage = 0;

  final TextEditingController phoneController = TextEditingController();
  bool isOtpSent = false;
  String? errorMessage;
  final String countryCode = "+91";

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselController();
    _videoControllers = videoPaths.map((path) {
      Uri uri = Uri.parse(path);
      if (uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
        return VideoPlayerController.networkUrl(uri);
      } else {
        return VideoPlayerController.asset(path);
      }
    }).toList();

    _chewieControllers = _videoControllers
        .map((controller) => ChewieController(
              videoPlayerController: controller,
              autoPlay: true,
              looping: true,
              allowFullScreen: true,
              allowMuting: false,
              showControlsOnInitialize: false,
              showOptions: false,
              autoInitialize: true,
              errorBuilder: (context, errorMessage) {
                print('Error: $errorMessage');
                return const Center(
                  child: Text('Error playing video'),
                );
              },
            ))
        .toList();

    _videoControllers[_currentPage].play(); // Start playing the first video
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.pause();
      controller.dispose();
    }
    for (var chewieController in _chewieControllers) {
      chewieController.pause();
      chewieController.dispose();
    }
    super.dispose();
  }

  void _onVideoTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Chewie(
                controller: _chewieControllers[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CarouselSlider(
            items: videoPaths.map((path) {
              int index = videoPaths.indexOf(path);
              return GestureDetector(
                onTap: () => _onVideoTap(index),
                child: Chewie(
                  controller: _chewieControllers[index],
                ),
              );
            }).toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: false,
              //autoPlayInterval: Duration(seconds: 100),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
                _videoControllers[_currentPage].play();
              },
              height: double.maxFinite,
              aspectRatio: 1,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction:
                  BouncingScrollSimulation.maxSpringTransferVelocity,
              pageSnapping: WidgetsApp.debugAllowBannerOverride,
            ),
          ),
          // Overlay with gradient and content
          Positioned.fill(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                  //     Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  //   ],
                  // ),
                  ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 00.0, right: 00.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Color.fromRGBO(131, 58, 180, 0.7),  // Instagram purple with medium opacity
                        // Color.fromRGBO(253, 29, 29, 0.6),   // Instagram red with slightly lower opacity
                        Color.fromRGBO(255, 255, 255,
                            0), // Instagram orange with even lower opacity
                        Color.fromRGBO(255, 255, 255,
                            0.4), // Instagram orange with slightly darker opacity
                        Color.fromRGBO(106, 84, 84,
                            0.29), // Instagram red with darker opacity
                        Color.fromRGBO(109, 101, 114, 0.5),
                        Color.fromRGBO(26, 15, 33,
                            1), // Instagram purple with medium opacity
                        Color.fromRGBO(97, 8, 93,
                            1), // Instagram purple with darkest opacity
                      ],

                      // colors: [
                      //   Color.fromRGBO(0, 0, 0, 0.498), // Darker color with 50% opacity at the top
                      //   Color.fromRGBO(85, 85, 85, 0.8), // Slightly lighter color with 80% opacity
                      // ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
//number textfiled
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 233, 226, 226),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text(
                                '+91',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight:
                                    0), // Allows the icon to be centered vertically
                            hintText: 'Enter your number',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.0,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 203, 203),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 208, 202, 202),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 227, 57, 227),
                                width: 2.0,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),

                      //SizedBox(height: 10.0),

                      // Get OTP button
                      ElevatedButton(
                        //       color: Colors.pink, // Text color (Instagram color)

                        // padding: EdgeInsets.zero,
                        child: const Text(
                          "Get OTP",
                          style: TextStyle(color: Colors.pink),
                        ),
                        onPressed: () async {
                          try {
                            String? validationMessage =
                                _validatePhoneNumber1(phoneController.text);

                            print(validationMessage);
                            if (validationMessage == null) {
                              final phoneNumber =
                                  countryCode + phoneController.text;
                              await userProvider.signInWithPhone(
                                  phoneNumber, context);
                            }
                          } catch (e) {
                            throw e.toString();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),

                      const SizedBox(height: 10.0),

                      TextButton(
                        onPressed: () async {
                          // Navigate to home screen as guest
                          try {
                            await userProvider.signInAnonymously(context);

                            _videoControllers.clear();
                          } on FirebaseAuthException catch (e) {
                            switch (e.code) {
                              case "operation-not-allowed":
                                break;
                              default:
                            }
                          }
                        },
                        child: const Text(
                          'Continue as Guest',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () async {
                          // GoogleSignInProvider googleAuthProvider =
                          //     GoogleSignInProvider();
                          // googleAuthProvider.signInWithGoogle().then((value) {
                          //   ReferralProvider refferalProvider =
                          //       ReferralProvider();
                          //   final code = refferalProvider.(8);
                          //   print(code);
                          //   if (value != null) {
                          //     // sendEmail(name: '', senderEmail: '');
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const BottomNavBarPage(
                          //           passedIndex: 10,
                          //         ),
                          //       ),
                          //     );
                          //   }
                          // });
                          //navigating to sign-up

                          // GoogleSignInProvider googleAuthProvider = GoogleSignInProvider();
                          // googleAuthProvider.signInWithGoogle().then((value) {
                          //   RefferalProvider refferalProvider = RefferalProvider();
                          //   final code = refferalProvider.generateRandomCode(8);
                          //   print(code);
                          //   if (value != null) {
                          //     // sendEmail(name: '', senderEmail: '');
                          //     Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => const BottomNavBarPage(
                          //                   passedIndex: 10,
                          //                 )));
                          //   }
                          // });
                          await userProvider.signInWithGoogle(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'OR CONNECT WITH',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10.0), // Adjust spacing between text and icons as needed
                              InkWell(
                                onTap: () async {
                                  await userProvider.signInWithGoogle(context);
                                },
                                child: Image.asset(
                                  'Assets/home_page/google_logo.png', // Replace with your actual image asset path
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String? _validatePhoneNumber1(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return "Please enter a phone number.";
  }

  String phoneNumberDigits = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (phoneNumberDigits.length != 10) {
    return "Phone number must have 10 digits.";
  }

  return null;
}
