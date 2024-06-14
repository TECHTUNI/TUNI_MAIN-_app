import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'combo_detail_page.dart';

class ComboPage extends StatelessWidget {
  ComboPage({Key? key});

  final firestore =
      FirebaseFirestore.instance.collection("combo_products").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Combo"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestore,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final int length = snapshot.data!.size;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                          List<dynamic> itemsInCombo =
                              document["combo_details"];
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
                                    thumbnailImageAndVideo:
                                        thumbnailImageAndVideo,
                                  ),
                                ),
                              );
                            },
                            child: GridTile(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade900,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(thumbnailImage),
                                        fit: BoxFit.cover)),
                                // child: Center(
                                //   child: Text(
                                //     comboName,
                                //     style: const TextStyle(
                                //         fontSize: 40,
                                //         fontWeight: FontWeight.bold,
                                //         letterSpacing: 2),
                                //   ),
                                // )
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
