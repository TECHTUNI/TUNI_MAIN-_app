import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedFAB extends StatefulWidget {
  final bool showExploreScreen;
  final VoidCallback onPressed;

  const AnimatedFAB({
    Key? key,
    required this.showExploreScreen,
    required this.onPressed,
    required bool isVisible,
  }) : super(key: key);

  @override
  _AnimatedFABState createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB> {
  late Timer _timer;
  bool _hasToggled = false;
  bool _isFABVisible = true;

  @override
  void initState() {
    super.initState();

    // Schedule the initial toggle to expand the FAB
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _hasToggled = true;
          });
        }
      });
    });

    // Timer to handle periodic toggling based on `showExploreScreen`
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (widget.showExploreScreen != _hasToggled) {
        setState(() {
          _hasToggled = widget.showExploreScreen;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 2),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.easeInOut,
        width: _hasToggled ? 150 : 56,
        height: 56,
        child: Visibility(
          visible: _isFABVisible,
          child: FloatingActionButton(
            key: ValueKey<bool>(_hasToggled),
            backgroundColor: Colors.purple[300],
            onPressed: () {
              widget.onPressed();
              setState(() {
                _isFABVisible = false; // Hide the FAB when pressed
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_hasToggled)
                  Expanded(
                    child: Text(
                      'Explore with GP-Tuni',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Image.asset('Assets/LOGO.png'),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_hasToggled ? 25.0 : 28.0),
            ),
          ),
        ),
      ),
    );
  }
}
