// class ComboModel {
//   String productId;
//   String productName;
//   String description;
//   String selectedSize;
//   String image;

//   ComboModel(
//       {required this.productId,
//       required this.productName,
//       required this.description,
//       required this.selectedSize,
//       required this.image});
// }

// class ComboProductListModel {
//   String id;
//   String name;
//   String description;
//   String imageUrl;

//   ComboProductListModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//   });

//   factory ComboProductListModel.fromMap(Map<String, dynamic> map) {
//     return ComboProductListModel(
//       id: map['id'],
//       name: map['name'],
//       description: map['description'],
//       imageUrl: map['imageturls'],
//     );
//   }
// }


//new ccode

class ComboModel {
  String productId;
  String productName;
  String description;
  String selectedSize;
  String image;

  ComboModel(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.selectedSize,
      required this.image});
}

class ComboProductListModel {
  String id;
  String name;
  String description;
  String imageUrl;

  ComboProductListModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory ComboProductListModel.fromMap(Map<String, dynamic> map) {
    return ComboProductListModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageturls'],
    );
  }
}