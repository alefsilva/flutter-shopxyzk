import 'package:flutter/material.dart';

void main() {
  runApp(const ShopEzy());
}

class ShopEzy extends StatelessWidget {
  const ShopEzy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text('ShopEzy s')),
        // body: Center(child: Text("Body..")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("ShopEzy")],
          ),
        ),
        backgroundColor: Colors.orange.shade50,
      ),
    );
  }
}
