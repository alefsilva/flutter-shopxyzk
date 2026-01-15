import 'package:flutter/material.dart';
import 'package:shopeazy/home_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

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
