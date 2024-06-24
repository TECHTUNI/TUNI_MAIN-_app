import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/presentation/pages/Home/platforms/andoid_home_refactor.dart';
import 'package:tuni/presentation/pages/auth/sign_in/Phone_auth/Phone_auth_confirmation.dart';
import 'package:tuni/presentation/pages/auth/sign_in/login.dart';
import 'package:tuni/presentation/pages/auth/sign_up/sign_up.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';
import 'package:video_player/video_player.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  List<String> videoPaths = [
    'https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2F_1717588086532?alt=media&token=8dcc0bd1-ebc9-460e-a522-d882f12e7c63',
    // Add more video paths here if needed
  ];

  late List<VideoPlayerController> _videoControllers;
  late List<ChewieController> _chewieControllers;
  late CarouselController _carouselController;
  // late List<ProductCategory> productList;
  // late List<ComboDetailPage> productList1;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselController();
    _videoControllers = videoPaths.map((path) {
      Uri uri = Uri.parse(path);
      if (uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
        return VideoPlayerController.network(uri.toString());
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
                return Center(
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: 1,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () => _onVideoTap(index),
                child: Chewie(
                  controller: _chewieControllers[index],
                ),
              );
            },
            carouselController: _carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
                _videoControllers[_currentPage].play();
              },
              height: double.maxFinite,
              aspectRatio: 1,
              autoPlay: false,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction:
                  BouncingScrollSimulation.maxSpringTransferVelocity,
              pageSnapping: WidgetsApp.debugAllowBannerOverride,
            ),
          ),
          // Overlay with gradient and content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Animated welcome text
                  AnimatedTextWidget(
                    text: 'Welcome to\nTUNi Club',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                      decoration:
                          TextDecoration.none, // Remove underline decoration
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.deepPurpleAccent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                        ).createShader(Rect.fromLTWH(
                            0.0, 0.0, 200.0, 70.0)), // Gradient text color
                    ),
                    duration: Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                  ),
                  SizedBox(height: 20.0),
                  // Description text
                  Text(
                    "Life isn't perfect, but your outfit can be!\nStyle is a way to say who you are without having to speak",
                    style: TextStyle(
                      color: Color.fromARGB(255, 204, 231, 95),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20.0),
                  // Get Started button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen or perform action
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text('Get Started'),
                  ),
                  SizedBox(height: 10.0), // Spacer

                  // Login with Phone button
                  TextButton(
                    onPressed: () {
                      // Navigate to login with phone screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhoneAuth()),
                      );
                    },
                    child: Text(
                      'Login with Phone Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  // Continue as Guest button
                  // TextButton(
                  //   onPressed: () {
                  //     // Navigate to home screen as guest
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => BottomNavBarPage()),
                  //     );
                  //   },
                  //   child: Text(
                  //     'Continue as Guest',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final Curve curve;

  const AnimatedTextWidget({
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
  });

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String _displayText;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _displayText = widget.text.split('\n').join(' ');

    _controller.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _displayText = widget.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        _displayText,
        style: widget.style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
