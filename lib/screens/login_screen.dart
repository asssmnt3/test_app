import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import halaman utama
import 'registration_screen.dart'; // Import halaman registrasi

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Simulasi penyimpanan data akun yang sudah diregistrasi
  Map<String, Map<String, String>> registeredAccounts = {
    'user@example.com': {
      'password': 'password123',
      'phone': '08123456789',
      'gender': 'Laki-laki',
    },
  };

  // Fungsi untuk memeriksa apakah akun sudah terdaftar
  bool _validateLogin(String email, String password) {
    return registeredAccounts[email]?['password'] == password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'), // Path gambar background
                fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran layar
              ),
            ),
          ),
          // Konten halaman login
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Input email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white.withOpacity(0.8), // Warna background input
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                // Input kata sandi
                TextField(
                  controller: _passwordController,
                  obscureText: true, // Agar teks tidak terlihat saat mengetik
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    fillColor: Colors.white.withOpacity(0.8), // Warna background input
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24.0),

                // Tombol Masuk
                ElevatedButton(
                  onPressed: () {
                    // Validasi login berdasarkan akun terdaftar
                    if (_validateLogin(
                      _emailController.text,
                      _passwordController.text,
                    )) {
                      // Jika akun valid, masuk ke halaman utama
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      // Jika akun tidak valid, tampilkan pesan kesalahan
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Gagal'),
                          content: Text('Email atau kata sandi salah atau belum terdaftar.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Masuk'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Tombol full width
                  ),
                ),
                SizedBox(height: 16.0),
                // Tombol untuk navigasi ke halaman registrasi
                TextButton(
                  onPressed: () {
                    // Navigasi ke halaman registrasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(
                          onRegister: (email, password, phone, gender) {
                            // Menyimpan akun yang diregistrasi
                            setState(() {
                              registeredAccounts[email] = {
                                'password': password,
                                'phone': phone,
                                'gender': gender,
                              };
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Belum punya akun? Daftar di sini'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
