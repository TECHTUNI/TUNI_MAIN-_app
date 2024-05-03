// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tuni/model/new_product model.dart';
// import 'package:tuni/provider/product_provider.dart';

// import 'pages/cart2.dart';
// import 'pages/cat1.dart';

// class CAt extends StatefulWidget {
//   // List<String> type = ["Pant", "Shirt", "Tshirt", "Shorts"];
//   final List<String> model = [
//     "full sleve",
//     "half sleve",
//     "collar",
//     "round neck",
//     "v-neck"
//   ];
//   CAt({Key? key}) : super(key: key);

//   @override
//   _CAtState createState() => _CAtState();
// }

// class _CAtState extends State<CAt> {
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // final productProvider =
//     //     Provider.of<ProdcuctProvider>(context, listen: false);
//     // productProvider.gethalfsleveTshirt();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('men'),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Consumer<ProdcuctProvider>(
//             builder: (context, productProvider, Widget? child) {
//               // List<Productdetails> halfSleeveProducts = productProvider.providerhalfsleve;
//               return Container(
//                 width: constraints.maxWidth,
//                 color: Colors.black,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: constraints.maxWidth * 0.2,
//                       color: const Color.fromARGB(255, 204, 203, 201),
//                       child: Column(
//                         children: [
//                           _buildCircleAvatarWithName(
//                               Icons.person, "full sleve", 0),
//                           _buildCircleAvatarWithName(
//                               Icons.person, "half sleve", 1),
//                           _buildCircleAvatarWithName(Icons.person, "collar", 2),
//                           _buildCircleAvatarWithName(
//                               Icons.person, "round neck", 3),
//                           _buildCircleAvatarWithName(Icons.person, "V neck", 4),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: constraints.maxWidth * 0.8,
//                       height: double.infinity,
//                       color: Colors.white,
//                       child: Center(
//                         child: _getScreenForIndex(_selectedIndex),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCircleAvatarWithName(
//     IconData icon,
//     String name,
//     int index,
//   ) {
//     bool isSelected = index == _selectedIndex;
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(
//                   'https://assets.ajio.com/medias/sys_master/root/20230615/Xs7z/648b116042f9e729d74492c4/-473Wx593H-466278337-white-MODEL.jpg'),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               name,
//               style: TextStyle(
//                 color: isSelected ? Colors.grey : Colors.black,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getScreenForIndex(int index) {
//     switch (index) {
//       case 0:
//         return Cat1(
//           type: 'Tshirt',
//           model: widget.model[index],
//         );
//       case 1:
//         return Cat1(
//           type: 'Tshirt',
//           model: widget.model[index],
//         );
//       case 2:
//         return Cat1(
//           type: 'Tshirt',
//           model: widget.model[index],
//         );
//       case 3:
//         return Cat1(
//           type: 'Tshirt',
//           model: widget.model[index],
//         );
//       default:
//         return Container();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/model/new_product model.dart';
import 'package:tuni/provider/product_provider.dart';

import 'pages/cart2.dart';
import 'pages/cat1.dart';

class CAt extends StatefulWidget {
  final List<String> model = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck"
  ];
  List<String> type = ["Pant", "Shirt", "Tshirt", "Shorts"];

  CAt({Key? key}) : super(key: key);

  @override
  _CAtState createState() => _CAtState();
}

class _CAtState extends State<CAt> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onIndexChanged(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
      Provider.of<ProdcuctProvider>(context, listen: false)
          .fetchallproduct('Tshirt', widget.model[newIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('men'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Consumer<ProdcuctProvider>(
            builder: (context, productProvider, Widget? child) {
              return Container(
                width: constraints.maxWidth,
                color: Colors.black,
                child: Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.2,
                      color: const Color.fromARGB(255, 204, 203, 201),
                      child: Column(
                        children: [
                          _buildCircleAvatarWithName(
                              Icons.person, "full sleve", 0),
                          _buildCircleAvatarWithName(
                              Icons.person, "half sleve", 1),
                          _buildCircleAvatarWithName(Icons.person, "collar", 2),
                          _buildCircleAvatarWithName(
                              Icons.person, "round neck", 3),
                          _buildCircleAvatarWithName(Icons.person, "V neck", 4),
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.8,
                      height: double.infinity,
                      color: Colors.white,
                      child: Center(
                        child: _getScreenForIndex(_selectedIndex),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCircleAvatarWithName(
    IconData icon,
    String name,
    int index,
  ) {
    bool isSelected = index == _selectedIndex;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          _onIndexChanged(index);
        },
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://assets.ajio.com/medias/sys_master/root/20230615/Xs7z/648b116042f9e729d74492c4/-473Wx593H-466278337-white-MODEL.jpg'),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.grey : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return Cat1(
          type: 'Tshirt',
          model: widget.model[index],
        );
      case 1:
        return Cat1(
          type: 'Tshirt',
          model: widget.model[index],
        );
      case 2:
        return Cat1(
          type: 'Tshirt',
          model: widget.model[index],
        );
      case 3:
        return Cat1(
          type: 'Tshirt',
          model: widget.model[index],
        );
      default:
        return Container();
    }
  }
}
