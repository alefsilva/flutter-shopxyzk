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
  List<Map> _filteredProducts = [];
  int _page = 0;

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
        _filteredProducts = _products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: appBar(),
      bottomNavigationBar: bottomNavigationBar(),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SearchBar(),
          SizedBox(height: 16.0),
          if (_products.isEmpty) ...[
            Spacer(),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.orange.shade300,
              ),
            ),
            Spacer(),
          ] else
            _page == 0 ? carouselSlider() : listWidget(),
          // TextButton(
          //   onPressed: () {
          //     debugPrint("Back to home");
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => HomeScreen()),
          //     );
          //   },
          //   child: Text(
          //     "Back to Home",
          //     style: TextStyle(fontSize: 15, color: Colors.orange.shade300),
          //   ),
          // ),
        ],
      ),
    );
  }

  dynamic listWidget() {
    var items = _filteredProducts.isNotEmpty ? _filteredProducts : _products;

    if (_filteredProducts.isEmpty) return renderEmptyResult();

    // return Text("List Widget");
    return Expanded(
      child: ListView(
        children: items.map((item) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 12.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            margin: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(item["image"], width: 100.0, height: 60.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item["title"]),
                      SizedBox(height: 5.0),
                      addCardButton(item),
                    ],
                  ),
                ),
                productRating(item, showOutOfFive: false),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Container SearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              // style: ,
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  if (value.isEmpty) {
                    _filteredProducts = _products;
                  } else {
                    _filteredProducts = _products
                        .where(
                          (product) => product["title"].toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                        )
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Search for products",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey.shade400,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _page,
      onTap: (value) {
        debugPrint("value: ${value}");
        setState(() {
          _page = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.swipe), label: "Swipe"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
      ],
    );
  }

  CarouselSlider carouselSlider() {
    if (_filteredProducts.isEmpty) {
      return renderEmptyResult();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;
    bool isDesktop = screenWidth >= 1024;
    double viewPort = isDesktop
        ? 0.2
        : isTablet
        ? 0.45
        : 0.8;

    return CarouselSlider(
      key: ValueKey(_filteredProducts.length),
      items: _filteredProducts.map((item) {
        return Padding(
          key: ValueKey(item["id"]),
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
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
                        child: productRating(item),
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
                      addCardButton(item),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: isDesktop
            ? 460
            : isTablet
            ? 550
            : 480,
        viewportFraction: viewPort,
        enlargeCenterPage: !isDesktop,
        enlargeFactor: 0.25,
        enableInfiniteScroll: _filteredProducts.length > 1,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
      ),
    );
  }

  CarouselSlider renderEmptyResult() {
    return CarouselSlider(
      items: [Text("Nenhum produto encontrado.")],
      options: CarouselOptions(),
    );
  }

  Container productRating(
    Map<dynamic, dynamic> item, {
    bool showOutOfFive = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
            "${item["rating"]["rate"]}${showOutOfFive ? "out of 5" : ""}",
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Row addCardButton(Map<dynamic, dynamic> item) {
    return Row(
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
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.orange.shade50,
      surfaceTintColor: Colors.orange.shade50,
      // surfaceTintColor: Colors.orange.shade100,
      // scrolledUnderElevation: 5.0,
      // shadowColor: Colors.grey.shade900,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Color(0xffC8B893)),
      title: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          },
          child: Text(
            "ShopEazy",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xffc8b893),
            ),
          ),
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                debugPrint("shopping_cart_checkout_rounded pressed");
              },
              icon: Icon(Icons.shopping_cart_checkout_rounded),
            ),
            Positioned(
              top: 0,
              right: 28.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _cartItems.length >= 1
                      ? Colors.orange.shade400
                      : Colors.white,
                ),
                // padding: EdgeInsets.only(top: 38.0, left: 38.0),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: _cartItems.length >= 1
                        ? Colors.black
                        : Color(0xffc8b893),
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
