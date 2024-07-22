import 'package:flutter/cupertino.dart';

class SweatShirtsInExplore extends StatelessWidget {
  const SweatShirtsInExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Sweatshirts".toUpperCase()),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Currently this category is not available!!"),
            ),
            SizedBox(height: 100,)

          ],
        ));
  }
}
