import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedFAB({super.key, required this.onPressed});

  @override
  AnimatedFABState createState() => AnimatedFABState();
}

class AnimatedFABState extends State<AnimatedFAB> {
  late Timer _timer;
  bool _showExploreScreen = false;
  final ValueNotifier<bool> _isDialogOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _startTimer();
    _isDialogOpen.addListener(() {
      if (_isDialogOpen.value) {
        _stopTimer();
      } else {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _showExploreScreen = !_showExploreScreen;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    _isDialogOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        width: _showExploreScreen ? 200 : 56,
        height: 56,
        child: FloatingActionButton(
          key: ValueKey<bool>(_showExploreScreen),
          backgroundColor: Colors.white,
          onPressed: widget.onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_showExploreScreen ? 25.0 : 28.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_showExploreScreen)
                const Expanded(
                  child: Text(
                    'Explore with GP-Tuni',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Image(
                    image: AssetImage('Assets/logo/Tuni logo.png'), // Ensure correct path
                    height: 40,
                    width: 40,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
