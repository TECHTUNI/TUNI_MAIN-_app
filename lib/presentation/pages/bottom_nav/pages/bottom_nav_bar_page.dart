import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../bloc/bnb_bloc/bottom_nav_bloc.dart';
import 'bottom_nav_bar_page_refactor.dart';

class BottomNavBarPage extends StatefulWidget {
  final int? passedIndex;
  const BottomNavBarPage({super.key, this.passedIndex});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  Color backgroundColor() {
    Color color = Colors.white;
    return color;
  }

  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.passedIndex ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    const BottomNavBarPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBloc, BottomNavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: bottomNavScreen.elementAt(state.tabIndex),
            ),
            bottomNavigationBar: GNav(
                activeColor: Colors.blueGrey.shade900,
                style: GnavStyle.google,
                onTabChange: (index) {
                  BlocProvider.of<BottomNavBloc>(context)
                      .add(TabChangeEvent(tabIndex: index));
                },
                selectedIndex: state.tabIndex,
                gap: 9,
                tabs: bottomNavItems));
      },
    );
  }
}
