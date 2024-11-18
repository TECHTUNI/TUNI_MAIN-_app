import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/core/provider/chat_provider.dart';
import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/bottom_nav_bar_page_refactor.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String sender;
  final String? image;
  final List<ProductCategory>? productDetails;

  const ChatBubble({
    required this.message,
    required this.sender,
    this.image,
    this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          sender == 'user' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: sender == 'user' ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (image != null) ...[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage(image!),
                    radius: 20.0,
                  ),
                  SizedBox(width: 8.0),
                ],
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                        color: sender == 'user' ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            if (productDetails != null) ...[
              SizedBox(height: 8.0),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productDetails!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to product detail page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                    brand: productDetails![index].brand,
                                    productId: productDetails![index].id,
                                    productName: productDetails![index].name,
                                    imageUrl:
                                        productDetails![index].imageUrlList,
                                    color: productDetails![index].color,
                                    price: productDetails![index].price,
                                    size: productDetails![index].size,
                                    category: productDetails![index].brand,
                                    gender: productDetails![index].gender,
                                    time: productDetails![index].time,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              productDetails![index].imageUrlList[0],
                              width: 100,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8.0),
                            Text(' ${productDetails![index].name}'),
                            Text('Price:₹${productDetails![index].price}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  String currentQuestion = 'Are you looking for Men or Women clothing?';
  String? selectedGender;
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedStyle;
  List<ProductCategory> productDetails = [];
  bool isLoading = false;
  final List<String> categories = ['Tshirt', 'Shirt', 'Pant'];

  final Map<String, List<String>> subcategories = {
    'Tshirt': ['full sleve', 'half sleve', 'collar', 'round neck', 'v-neck'],
    'Shirt': ['Half sleeve', 'Full sleeve'],
    'Pant': ['Jeans', 'Chinos', 'Shorts'],
  };

  final List<String> styles = ['Plain', 'Printed', 'check'];
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> chatMessages = [
    {
      'message': 'Hi , I am GP-Tuni   . How can I assist you?',
      'sender': 'bot',
      'image': 'Assets/Images/logo1.png',
      'productDetails': null,
    }
  ];

  ScrollController _scrollController = ScrollController();

  void fetchProductDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      ChatProvider productProvider =
          Provider.of<ChatProvider>(context, listen: false);
      List<ProductCategory> products = await productProvider.fetchChatProducts(
        selectedGender!,
        selectedCategory!,
        selectedSubcategory!,
        selectedStyle!,
      );
      setState(() {
        productDetails = products;
        isLoading = false;
        _addBotMessage(
          'Here are the products for $selectedSubcategory ($selectedStyle)',
          productDetails: productDetails,
        );
      });
    } catch (error) {
      print('Error fetching product details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    productDetails.clear();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        chatMessages.add({'message': message, 'sender': 'user'});
        _messageController.clear();
        FocusScope.of(context).unfocus();
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    setState(() {
      chatMessages = [
        {
          'message': 'Hi , I am GP-Tuni   . How can I assist you?',
          'sender': 'bot',
          'image': 'Assets/Images/logo1.png',
          'productDetails': null,
        }
      ];
      currentQuestion = 'Are you looking for Men or Women clothing?';
      selectedGender = null;
      selectedCategory = null;
      selectedSubcategory = null;
      selectedStyle = null;
      productDetails.clear();
    });
  }

  void _addBotMessage(String message,
      {String? image, List<ProductCategory>? productDetails}) {
    setState(() {
      chatMessages.add({
        'message': message,
        'sender': 'bot',
        'image': image,
        'productDetails': productDetails,
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GP-Tuni'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarPage()),
              (route) => false,
            );
          },
        ),
        actions: [
          TextButton(
              onPressed: _clearChat,
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: chatMessages[index]['message']!,
                    sender: chatMessages[index]['sender']!,
                    image: chatMessages[index]['image'],
                    productDetails: chatMessages[index]['productDetails'],
                  );
                },
              ),
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
            SizedBox(height: 8.0),
            buildButtonRow(),
            SizedBox(height: 8.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your custom requirement',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow() {
    if (selectedGender == null) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: ['Men', 'Women'].map((gender) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedGender = gender;
                currentQuestion =
                    'What category are you looking for in $gender clothing?';
                _addBotMessage(currentQuestion);
              });
            },
            child: Text(gender),
          );
        }).toList(),
      );
    } else if (selectedCategory == null) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: categories.map((category) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategory = category;
                currentQuestion = 'Select a subcategory for $category';
                _addBotMessage(currentQuestion);
              });
            },
            child: Text(category),
          );
        }).toList(),
      );
    } else if (selectedSubcategory == null) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: subcategories[selectedCategory!]!.map((subcategory) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedSubcategory = subcategory;
                currentQuestion = 'Select a style for $subcategory';
                _addBotMessage(currentQuestion);
              });
            },
            child: Text(subcategory),
          );
        }).toList(),
      );
    } else if (selectedStyle == null) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: styles.map((style) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedStyle = style;
                fetchProductDetails();
                currentQuestion =
                    'Fetching products for $selectedSubcategory ($selectedStyle)...';
                _addBotMessage(currentQuestion);
              });
            },
            child: Text(style),
          );
        }).toList(),
      );
    } else {
      return SizedBox();
    }
  }
}
