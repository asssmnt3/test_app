import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background gambar
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'), // Path gambar background
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo di tengah layar
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman login ketika logo diklik
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Image.asset(
                'assets/logoskin.png', // Path gambar logo
                width: 400,
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
