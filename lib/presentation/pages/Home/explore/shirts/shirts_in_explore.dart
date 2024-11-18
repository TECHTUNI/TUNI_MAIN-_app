import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/Home/explore/shirts/shirt_category_item_view.dart';
import 'package:tuni/presentation/pages/Home/explore/tshirts/refactor_tshirt_in_explore.dart';
import '../../../../../core/provider/tshirt_category_provider.dart';

class ShirtsInExplore extends StatefulWidget {
  const ShirtsInExplore({super.key});

  @override
  ShirtsInExploreState createState() => ShirtsInExploreState();
}

class ShirtsInExploreState extends State<ShirtsInExplore> {
  int _selectedIndex = 0;

  void _onIndexChanged(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Shirts".toUpperCase(),
          style: const TextStyle(letterSpacing: 1.5),
        ),
        border: const Border(bottom: BorderSide.none),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "All",
                  isSelected: _selectedIndex == 0,
                  onTap: () {
                    _onIndexChanged(0);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "Casual",
                  isSelected: _selectedIndex == 1,
                  onTap: () {
                    _onIndexChanged(1);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "Formal",
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    _onIndexChanged(2);
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<TShirtCategoryProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  width: double.infinity,
                  child: _getScreenForIndex(_selectedIndex),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const ShirtCategoryItemView(
          category: "Shirt",
          type: 'All',
        );
      case 1:
        return const ShirtCategoryItemView(
          category: "Shirt",
          type: 'Casual',
        );
      case 2:
        return const ShirtCategoryItemView(
          category: "Shirt",
          type: 'Formal',
        );
      default:
        return Container();
    }
  }
}
