import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/Home/explore/tshirts/tshirt_category_item_view.dart';
import 'package:tuni/presentation/pages/Home/explore/tshirts/refactor_tshirt_in_explore.dart';
import '../../../../../core/provider/tshirt_category_provider.dart';
import '../../../search/search_widget.dart';

class TShirtsInExplore extends StatefulWidget {
  const TShirtsInExplore({Key? key}) : super(key: key);

  @override
  TShirtsInExploreState createState() => TShirtsInExploreState();
}

class TShirtsInExploreState extends State<TShirtsInExplore> {
  int _selectedIndex = 0;

  void _onIndexChanged(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T-Shirts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start (left)
        children: [
          const SizedBox(height: 20), // Adjusted height
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
                  text: "Full Sleeve",
                  isSelected: _selectedIndex == 1,
                  onTap: () {
                    _onIndexChanged(1);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "Half Sleeve",
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    _onIndexChanged(2);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "Collar",
                  isSelected: _selectedIndex == 3,
                  onTap: () {
                    _onIndexChanged(3);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "Round Neck",
                  isSelected: _selectedIndex == 4,
                  onTap: () {
                    _onIndexChanged(4);
                  },
                ),
                const SizedBox(width: 10),
                ItemTypeContainer(
                  text: "V Neck",
                  isSelected: _selectedIndex == 5,
                  onTap: () {
                    _onIndexChanged(5);
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 10), // Adjusted height
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
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'All',
        );
      case 1:
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'Full Sleeve',
        );
      case 2:
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'Half Sleeve',
        );
      case 3:
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'Collar',
        );
      case 4:
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'Round Neck',
        );
      case 5:
        return const TShirtCategoryItemView(
          category: "TShirt",
          type: 'V Neck',
        );
      default:
        return Container();
    }
  }
}
