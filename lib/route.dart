import 'package:flutter/material.dart';

class Route2 extends StatefulWidget {
  const Route2({super.key});
  static const r = 'r';
  @override
  State<Route2> createState() => _Route2State();
}

class _Route2State extends State<Route2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Fotos y videos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 79, 109),
      ),
    );
  }
}
