import 'package:flutter/material.dart';

class Homebackground extends StatelessWidget {
  const Homebackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
