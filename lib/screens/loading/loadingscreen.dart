

import 'package:flutter/material.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: CircularProgressIndicator(
                    color: Colors.black,
                ),
            ),
    );
  }
}
