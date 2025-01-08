import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final Function(String, String, String, String) onRegister; // Tambahkan nomor telepon & gender

  RegistrationScreen({required this.onRegister});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedGender; // Gender yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cream.jpg'), // Path gambar background
                fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran layar
              ),
            ),
          ),
          // Form registrasi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Input email
                _buildInputField(_emailController, 'Email'),
                SizedBox(height: 16.0),
                // Input nomor telepon
                _buildInputField(_phoneController, 'Nomor Telepon'),
                SizedBox(height: 16.0),
                // Input kata sandi
                _buildInputField(_passwordController, 'Kata Sandi', obscureText: true),
                SizedBox(height: 16.0),
                // Input konfirmasi kata sandi
                _buildInputField(_confirmPasswordController, 'Konfirmasi Kata Sandi', obscureText: true),
                SizedBox(height: 16.0),
                // Pilihan jenis kelamin
                _buildGenderDropdown(),
                SizedBox(height: 24.0),
                // Tombol Registrasi
                ElevatedButton(
                  onPressed: () {
                    // Validasi input
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _selectedGender == null) {
                      // Tampilkan pesan jika ada input yang kosong
                      _showErrorDialog('Semua kolom harus diisi.');
                    } else if (_passwordController.text != _confirmPasswordController.text) {
                      // Tampilkan pesan jika kata sandi tidak cocok
                      _showErrorDialog('Kata sandi tidak cocok.');
                    } else {
                      // Jika semua valid, kirim data registrasi
                      widget.onRegister(
                        _emailController.text,
                        _passwordController.text,
                        _phoneController.text,
                        _selectedGender!,
                      );
                      Navigator.pop(context); // Kembali ke halaman login setelah registrasi
                    }
                  },
                  child: Text('Daftar'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Tombol full width
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat input field
  Widget _buildInputField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white.withOpacity(0.8),
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Fungsi untuk menampilkan dropdown gender
  Widget _buildGenderDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: _selectedGender,
        hint: Text('Pilih Jenis Kelamin'),
        items: [
          DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
          DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedGender = value;
          });
        },
        underline: SizedBox(), // Menghilangkan garis bawah default
      ),
    );
  }

  // Fungsi untuk menampilkan dialog error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
