import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/gp_tuni_provider.dart';
import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';
import 'message_input_fields.dart';

class GPTuni extends StatefulWidget {
  final VoidCallback onClose;

  const GPTuni({super.key, required this.onClose});

  @override
  GPTuniState createState() => GPTuniState();
}

class GPTuniState extends State<GPTuni> {
  final ScrollController _scrollController = ScrollController();
  late GPTuniProvider _chatProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatProvider = Provider.of<GPTuniProvider>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _resetChat() {
    setState(() {
      _chatProvider.resetChat();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _chatProvider,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.clear, color: Colors.red),
            onPressed: () {
              widget.onClose();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.green),
              onPressed: _resetChat,
            ),
          ],
          title: const Text("GP-TUNi"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<GPTuniProvider>(
                builder: (context, chatProvider, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    }
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return Column(
                        crossAxisAlignment: message.isSentByMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (message.imageUrl != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Image.asset(
                                message.imageUrl!,
                                height: 150,
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            alignment: message.isSentByMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: message.isSentByMe
                                    ? Colors.blue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message.text,
                                style: TextStyle(
                                  color: message.isSentByMe
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          if (message.options != null)
                            Wrap(
                              children: message.options!.map((option) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      chatProvider.addAnswer(option);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text(option),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Consumer<GPTuniProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.productsFetched) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: chatProvider.finalList.length,
                          itemBuilder: (context, index) {
                            final product = chatProvider.finalList[index];
                            String productPrice = product.price;
                            List image = product.imageUrlList;
                            String productName = product.name;
                            String productId = product.id;
                            List imageUrlList = product.imageUrlList;
                            String color = product.color;
                            String brand = product.brand;
                            String category = product.brand;
                            List size = product.size;
                            String gender = product.gender;
                            String time = product.time;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                        productId: productId,
                                        productName: productName,
                                        price: productPrice,
                                        imageUrl: image,
                                        color: color,
                                        brand: brand,
                                        category: category,
                                        size: size,
                                        gender: gender,
                                        time: time,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrlList[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      productName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹$productPrice',
                                      style: const TextStyle(
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            MessageInputField(),
          ],
        ),
      ),
    );
  }
}
