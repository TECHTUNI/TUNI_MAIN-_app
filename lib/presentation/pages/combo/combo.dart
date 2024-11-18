import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'combo_detail_page.dart';

class ComboPage extends StatefulWidget {
  const ComboPage({super.key, });

  @override
  _ComboPageState createState() => _ComboPageState();
}

class _ComboPageState extends State<ComboPage> {
  String selectedGender = 'All'; // Default gender filter
  String selectedCombo = 'All'; // Default combo filter

  Stream<QuerySnapshot> getFilteredCombos() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection("combo_products");

    if (selectedGender != 'All') {
      query = query.where('gender', isEqualTo: selectedGender);
    }

    if (selectedCombo == 'Combo 1') {
      query = query.where('price', isEqualTo: '2499');
    } else if (selectedCombo == 'Combo 2') {
      query = query.where('price', isEqualTo: '4999');
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Combo"),
      ),
      body: Column(
        children: [
          // Filter controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Gender Filter Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    isExpanded: true,
                    items: <String>['All', 'Men', 'Women'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('Select Gender'),
                  ),
                ),
                const SizedBox(width: 16),
                // Combo Filter Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCombo,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCombo = newValue!;
                      });
                    },
                    isExpanded: true,
                    items: <String>['All', 'Combo 1', 'Combo 2'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('Select Combo'),
                  ),
                ),
              ],
            ),
          ),
          // Display filtered content
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getFilteredCombos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 6, // Display 6 shimmer placeholders
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey,
                          margin: const EdgeInsets.all(8.0),
                        );
                      },
                    ),
                  );
                }

                final int length = snapshot.data!.size;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    String comboId = document['id'];
                    String brand = document['brand'];
                    String comboType = document['combotype'];
                    String comboName = document['name'];
                    String comboDescription = document['description'];
                    String comboPrice = document['price'];
                    String comboQuantity = document['quantity'];
                    Timestamp timeStamp = document['timestamp'];
                    String comboCountString = document['combo_count'];
                    int comboCount = int.parse(comboCountString[0]);
                    String comboCategory = document['gender'];
                    List<dynamic> itemsInCombo = document["combo_details"];
                    String thumbnailImage = document['tumbnail'];
                    String thumbnailVideo = document['videoUrl'];
                    List<Map<String, dynamic>> thumbnailImageAndVideo = [
                      {
                        "id": "thumbnailImage",
                        "name": comboName,
                        "description": comboDescription,
                        "url": thumbnailImage
                      },
                    ];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComboDetailPage(
                              comboId: comboId,
                              brand: brand,
                              comboType: comboType,
                              comboName: comboName,
                              comboDescription: comboDescription,
                              comboPrice: comboPrice,
                              comboQuantity: comboQuantity,
                              timestamp: timeStamp,
                              comboCount: comboCount,
                              comboCategory: comboCategory,
                              itemsInCombo: itemsInCombo,
                              thumbnailImage: thumbnailImage,
                              thumbnailVideo: thumbnailVideo,
                              thumbnailImageAndVideo: thumbnailImageAndVideo,
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(thumbnailImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
