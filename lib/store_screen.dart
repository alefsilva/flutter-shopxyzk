import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopeazy/home_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Map> _products = [];
  final List<int> _cartItems = [];

  @override
  void initState() {
    super.initState();
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    get(uri).then((productsResponse) {
      debugPrint("productsResponse.body: ${productsResponse.body}");
      final data = jsonDecode(productsResponse.body) as List;
      debugPrint("data.runtimeType: ${data.runtimeType}");
      setState(() {
        _products.addAll(data.map((item) => item as Map));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: appBar(),
      body: Column(
        children: [
          Text("Search Bar"),
          carouselSlider(),
          TextButton(
            onPressed: () {
              debugPrint("Back to home");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
            child: Text(
              "Back to Home",
              style: TextStyle(fontSize: 15, color: Colors.orange.shade300),
            ),
          ),
        ],
      ),
    );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider(
      items: _products.map((item) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 15.0),
                          SizedBox(width: 4.0),
                          Text(
                            "${item["rating"]["rate"]} out of 5",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Image.network(item["image"], height: 200.00),
                  Spacer(),
                  SizedBox(height: 12.0),
                  Text(
                    maxLines: 2,
                    item["title"],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    maxLines: 3,
                    item["description"],
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "\$${item["price"]}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      InkWell(
                        onTap: () {
                          setState(() {
                            debugPrint("card shopping_cart_rounded tapped");
                            int id = item["id"];
                            if (_cartItems.contains(id)) {
                              _cartItems.remove(id);
                            } else {
                              _cartItems.add(id);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.shade50,
                          ),
                          child: Icon(
                            _cartItems.contains(item["id"])
                                ? Icons.remove_shopping_cart_rounded
                                : Icons.shopping_cart_rounded,
                            size: 20.0,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 480,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.orange.shade50,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Color(0xffC8B893)),
      title: Center(
        child: Text(
          "ShopEazy",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xffc8b893),
          ),
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                debugPrint("shopping_cart_checkout_rounded pressed");
              },
              icon: Icon(Icons.shopping_cart_checkout_rounded),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                // padding: EdgeInsets.only(top: 38.0, left: 38.0),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffc8b893),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
