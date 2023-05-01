import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoRed,
                  child: const Text(
                    'J-Flix merupakan sebuah aplikasi katalog film yang dikembangkan oleh Jordy Dave',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
