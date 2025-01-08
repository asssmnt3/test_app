import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import halaman profil
import 'youtube_screen.dart'; // Import halaman YouTube player
import 'favorite_screen.dart';
import 'chat_screen.dart'; // Import halaman chat
import 'calculator_screen.dart'; // Import halaman kalkulator
import 'phonebook_screen.dart';
import 'conversion_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> products = [
    {'image': 'assets/kk1.png', 'name': 'Saltair Bodywash', 'description': 'Diperkaya dengan Niacinamide.', 'price': 'Rp 150.000'},
    {'image': 'assets/kk2.png', 'name': 'Lavojoy Hair Shampoo', 'description': 'Shampoo non-SLS yang melembabkan.', 'price': 'Rp 120.000'},
    {'image': 'assets/kk3.png', 'name': 'Simple Micellar Water', 'description': 'Pembersih wajah non-alcohol.', 'price': 'Rp 90.000'},
    {'image': 'assets/kk4.png', 'name': 'La Roche Posay Vit.C', 'description': 'Vitamin C yang efektif.', 'price': 'Rp 250.000'},
    {'image': 'assets/dior.jpeg', 'name': 'Dior Lipstick', 'description': 'Shade01, Tiramisu', 'price': 'Rp 320.000'},
    {'image': 'assets/cushion.jpeg', 'name': 'Barenbliss Cushion', 'description': 'Shade 42N Sand', 'price': 'Rp 180.000'},
    {'image': 'assets/eye.jpeg', 'name': 'Harlette Eyecream', 'description': 'Diperkaya dengan Vit.C dan Glutathione', 'price': 'Rp 140.000'},
    {'image': 'assets/moist.jpeg', 'name': 'Skintific Ceramide Moisturizer', 'description': 'Untuk kulit sensitif', 'price': 'Rp 160.000'},
    {'image': 'assets/settingspray.jpeg', 'name': 'Dazzle Me Setting Spray', 'description': 'Mengunci make up tahan lama', 'price': 'Rp 100.000'},
    {'image': 'assets/mask.jpeg', 'name': 'Skintific Mugwort Clay Mask', 'description': 'Mask untuk kulit berjerawat', 'price': 'Rp 130.000'},
  ];

  List<int> favoriteIndices = []; // Menyimpan indeks produk favorit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.white70,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgHome.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/katarina.png', width: 60, height: 60),
                      SizedBox(width: 10),
                      Text(
                        'HALO KARINA',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isFavorite = favoriteIndices.contains(index);
                      return Card(
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  product['image']!,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isFavorite) {
                                          favoriteIndices.remove(index);
                                        } else {
                                          favoriteIndices.add(index);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name']!,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product['description']!,
                                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['price']!,
                                    style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Videos'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'), // Tambah ikon kalkulator
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Phone Book'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Konversi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),

        ],
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YouTubeScreen(
                  videoUrls: [
                    'https://youtu.be/U0svrc0TDQM?si=xUh6aKNNQC4KpWR-',
                    'https://youtu.be/H6-6vb6yDYE?si=2agMGJrv_Q8uoEM1',
                    'https://youtu.be/vhpH3681yvw?si=oPAWF54yxN1NkUH0',
                  ],
                ),
              ),
            );
          } else if (index == 7) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteScreen(favoriteProducts: favoriteIndices.map((i) => products[i]).toList()),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          } else if (index == 4) { // Menu kalkulator
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalculatorScreen(),
              ),
            );
          }else if (index == 5) { // Menu Phone Book
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhoneBookScreen(),
              ),
            );
          }else if (index == 6) { // Menu Konversi
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversionScreen(),
              ),
            );
          }


        },
      ),
    );
  }
}
