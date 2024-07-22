import 'package:flutter/cupertino.dart';

class JeansInExplore extends StatelessWidget {
  const JeansInExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("jeans".toUpperCase()),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Currently this category is not available!!"),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ));
  }
}
