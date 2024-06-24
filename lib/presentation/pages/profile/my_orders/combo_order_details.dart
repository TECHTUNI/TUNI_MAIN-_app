import 'package:flutter/material.dart';
import 'package:tuni/presentation/pages/profile/my_orders/combo_orderrefactor.dart';
import 'my_orders_refactor.dart';

class ComboOrderDetailPage extends StatefulWidget {
  final String orderId;
  final Map<String, dynamic> address;
  final List<Map<String, dynamic>>? selectedItems;
  final Map<String, dynamic>? productDetailsCombo;

  const ComboOrderDetailPage(
      {super.key,
      required this.orderId,
      required this.address,
      this.selectedItems,
      this.productDetailsCombo});

  @override
  ComboOrderDetailPageState createState() => ComboOrderDetailPageState();
}

class ComboOrderDetailPageState extends State<ComboOrderDetailPage> {
  late int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    // final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text(
      //     "Order Details",
      //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
      //   ),
      //   border: Border(bottom: BorderSide.none),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Order ID: ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: widget.orderId,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ])),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: .1),
                  // borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Thank you".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1)),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Center(
                    //     child: Text(
                    //       "ORDER NUMBER: #34521",
                    //       style: const TextStyle(
                    //           letterSpacing: 1,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 17),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "We've received your order!",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Your order will be received in 2-3 working days. Keep shopping with us.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            Text("Keep Shopping With Us!",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const DividerLineForCupertino(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productDetailsCombo?["name"],
                                    style: const TextStyle(
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text("TUNi"),
                                  const SizedBox(height: 5),
                                  Text(
                                    "₹${widget.productDetailsCombo?["price"]}",
                                    style: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            widget.productDetailsCombo?["tumbnail"],
                            height: 150,
                          )
                          // Container(
                          //   // height: 400,
                          //   // width: 150,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: NetworkImage(widget.imageUrl),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const DividerLineForCupertino(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("selected items: "),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 300,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.selectedItems?.length,
                                    itemBuilder: (context, index) {
                                      final size = widget.selectedItems?[index]
                                          ["selectedSize"];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              widget.selectedItems?[index]
                                                  ["image"],
                                              height: 60,
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              children: [
                                                Text(
                                                    widget.selectedItems?[index]
                                                        ["productName"]),
                                                Text(size != "Not applicable"
                                                    ? size
                                                    : "")
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const DividerLineForCupertino(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Shipping Address:"),
                              const SizedBox(height: 10),
                              // AddressHeadingInOrderDetails(
                              //     text: widget.address["username"]),
                              // AddressHeadingInOrderDetails(
                              //     text: "+91${widget.address["phoneNumber"]}"),
                              // const SizedBox(height: 5),
                              // Text(
                              //   "${widget.address["address_Line1"]} ",
                              //   style: addressInOrderDetailsTextStyle(),
                              // ),
                              // Text(
                              //   "${widget.address["address_Line2"]}, ${widget.address["city"]} ",
                              //   style: addressInOrderDetailsTextStyle(),
                              // ),
                              // Text(
                              //   "${widget.address["state"]},",
                              //   style: addressInOrderDetailsTextStyle(),
                              // ),
                              // Text(
                              //   "${widget.address["state"]} - ${widget.address["pincode"]} ",
                              //   style: addressInOrderDetailsTextStyle(),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle addressInOrderDetailsTextStyle() => TextStyle(fontSize: 20);
}
