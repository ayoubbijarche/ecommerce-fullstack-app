import 'package:flutter/material.dart';
import './component/productslist.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
                ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                child:
                Image.asset(
                    "assets/images/bg2.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                ),),

                const Productlist(),
                 const Align(
                    alignment: Alignment(-0.4, -0.3),
                    child: 
                        Stack(
                        children: [
                            Text(
                                "The Best",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold
                                    ),
                                ),
                            
                            Padding(
                                padding: EdgeInsets.only(top: 50),
                                child:
                                    Text(
                                        "Air Refreshing and",
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),),

                           Padding(
                                padding: EdgeInsets.only(top: 90),
                                child:
                                    Text(
                                        "Most Beautiful Plants",
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),),
                            ]
                        ),
                    ),
            ],
        ),
    );
  }
}
