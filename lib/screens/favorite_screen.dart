import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Map<String, String>> favoriteProducts;

  // Konstruktor yang menerima parameter favoriteProducts
  FavoriteScreen({required this.favoriteProducts});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
        backgroundColor: Colors.transparent, // Transparan agar gambar latar tetap terlihat
        elevation: 0, // Menghilangkan shadow pada AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cream.jpg'), // Ganti dengan gambar latar yang Anda inginkan
            fit: BoxFit.cover, // Menyesuaikan gambar dengan layar
          ),
        ),
        child: ListView.builder(
          itemCount: widget.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = widget.favoriteProducts[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      product['image']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            product['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['price']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Hapus produk dari daftar favorit
                        setState(() {
                          widget.favoriteProducts.removeAt(index);
                        });

                        // Feedback ke pengguna setelah menghapus produk
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product removed from favorites')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
