import 'package:flutter/material.dart';

class home_background extends StatelessWidget {
  const home_background({super.key});

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
