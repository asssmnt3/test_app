import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  SearchScreen({required this.products}); // Konstruktor menerima daftar produk

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<Map<String, String>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products; // Produk awal sebelum pencarian
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      query = newQuery;
      filteredProducts = widget.products.where((product) {
        return product['name']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search product...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: updateSearchQuery, // Memperbarui query pencarian
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  leading: Image.asset(
                    product['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product['name']!),
                  subtitle: Text(product['description']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
