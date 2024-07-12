import 'package:ecommerce_sample/screens/home/home.dart';
import 'cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';


class CurrentRoute extends StatefulWidget {
  const CurrentRoute({super.key});
  @override
  State<CurrentRoute> createState() => _CurrentRouteState();
}

class _CurrentRouteState extends State<CurrentRoute> {
  int _index = 0;



  @override
  Widget build(BuildContext context) {
    List<Widget> body = const [
      Homepage(),
      CartPage(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: body[_index],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(-4, 5),
            )
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          unselectedItemColor: const Color(0xFF949494),
          selectedItemColor: Colors.black,
          currentIndex: _index,
          onTap: (int newindex) {
            setState(() {
              _index = newindex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(UniconsLine.store), label: "Store"),
            BottomNavigationBarItem(icon: Icon(UniconsLine.shopping_bag), label: "Cart")
          ],
        ),
      ),
    );
  }
}
