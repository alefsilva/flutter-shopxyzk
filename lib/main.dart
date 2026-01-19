import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopxyzk/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.black45),
  );
  runApp(const ShopXYZK());
}

class ShopXYZK extends StatelessWidget {
  const ShopXYZK({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
