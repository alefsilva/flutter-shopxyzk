import 'package:flutter/material.dart';
import 'package:shopeazy/store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 300.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100.withAlpha(-4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150.0),
                      topRight: Radius.circular(150.0),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "ShopEazy",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            TextButton(
              onPressed: () {
                debugPrint("Button pressed2");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StoreScreen()),
                );
              },
              child: Text(
                "Open Store",
                style: TextStyle(fontSize: 15, color: Colors.orange.shade300),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50,
    );
  }
}
