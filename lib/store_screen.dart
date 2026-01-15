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

  @override
  void initState() {
    super.initState();
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    get(uri).then((productsResponse) {
      debugPrint("productsResponse.body: ${productsResponse.body}");
      final data = jsonDecode(productsResponse.body) as List;
      debugPrint("data.runtimeType: ${data.runtimeType}");
      _products.addAll(data.map((item) => item as Map));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
