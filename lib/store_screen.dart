import 'dart:convert';

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
  final int _cartLength = 0;

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
          Text("Store Screen"),
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
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_rounded),
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
                  "$_cartLength",
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
