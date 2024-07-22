import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tuni/presentation/pages/Cart/checkout/select_address.dart';
import 'package:tuni/presentation/pages/profile/my_orders/Order_progress_bar/order_bar.dart';
 
class LocationAutoComplete extends StatefulWidget {
  const LocationAutoComplete({Key? key}) : super(key: key);
 
  @override
  _LocationAutoCompleteState createState() => _LocationAutoCompleteState();
}
 
class _LocationAutoCompleteState extends State<LocationAutoComplete> {
  final TextEditingController searchController = TextEditingController();
  final String token = '1234567890';
  final String apiKey =
      "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow"; // Replace with your Google Maps API key
  List<dynamic> listOfLocation = [];
  List<String> selectedAddresses = []; // List to store selected addresses
 
  @override
  void initState() {
    super.initState();
    searchController.addListener(_onChange);
  }
 
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
 
  void _onChange() {
    placeSuggestion(searchController.text);
  }
 
  Future<void> placeSuggestion(String input) async {
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception(
            "Failed to load locations. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching location suggestions: $e');
    }
  }
 
  void addToSelectedAddresses(String address) {
    setState(() {
      selectedAddresses.add(address);
      searchController.clear(); // Clear the search field
      listOfLocation.clear(); // Clear the suggestions list
    });
  }
 
  @override
 Widget build(BuildContext context) {
  return Column(
    children: [
      TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: "Search place...",
        ),
        onChanged: (value) {
          _onChange(); // Call the _onChange method here
        },
      ),

      // Suggestions
      listOfLocation.isNotEmpty
          ?Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOfLocation.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      addToSelectedAddresses(listOfLocation[index]["description"]);
                    },
                    child: ListTile(
                      title: Text(
                        listOfLocation[index]["description"],
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),

      // Selected Addresses
      SizedBox(height: 10),
      Text(
        "Selected Addresses:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(height: 10),

     // List of Selected Addresses
      Expanded(
        child: Container(
          height: 150, // Increased height for selected addresses
          child: ListView.builder(
            itemCount: selectedAddresses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedAddresses[index]),
              );
            },
          ),
        ),
      ),
    ],
  );

   //return page main do not uncooment it
   
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           "Location AutoComplete",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
// //             Navigator.pushAndRemoveUntil(
// //   context,
// //   MaterialPageRoute(
// //     builder: (context) => SelectAddress(
// //       orderList: , // Replace with actual list of CartItemModel
// //       total: calculatedTotalAmount, // Replace with actual total amount
// //       ids: ['id1', 'id2'], // Replace with actual list of IDs
// //     ),
// //   ),
// //   (route) => false,
// // );
           
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Search TextField
//               TextField(
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   hintText: "Search place...",
//                 ),
//                 onChanged: (value) {
//                   _onChange(); // Call the _onChange method here
//                 },
//               ),
//               SizedBox(height: 10),
 
//               // Suggestions
//               listOfLocation.isNotEmpty
//                   ? ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: listOfLocation.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             addToSelectedAddresses(
//                                 listOfLocation[index]["description"]);
//                           },
//                           child: ListTile(
//                             title: Text(
//                               listOfLocation[index]["description"],
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : Container(),
 
//               // Selected Addresses
//               SizedBox(height: 10),
//               Text(
//                 "Selected Addresses:",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 10),
 
//               // List of Selected Addresses
//               Container(
//                 height: 550, // Increased height for selected addresses
//                 child: ListView.builder(
//                   itemCount: selectedAddresses.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(selectedAddresses[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
  }
}