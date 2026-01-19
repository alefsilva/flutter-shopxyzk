import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopeazy/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.black45),
  );
  runApp(const ShopEazy());
}

class ShopEazy extends StatelessWidget {
  const ShopEazy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
