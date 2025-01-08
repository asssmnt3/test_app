import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 Tab: Suhu, Mata Uang, Berat
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.thermostat), text: 'Suhu'),
            Tab(icon: Icon(Icons.money), text: 'Mata Uang'),
            Tab(icon: Icon(Icons.scale), text: 'Berat'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cream.jpg'), // Ganti path sesuai lokasi file Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: [
              TemperatureConversion(),
              CurrencyConversion(),
              WeightConversion(),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget untuk konversi suhu
class TemperatureConversion extends StatelessWidget {
  final TextEditingController tempController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: tempController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Masukkan suhu dalam Celsius'),
          ),
          ElevatedButton(
            onPressed: () {
              final celsius = double.tryParse(tempController.text) ?? 0.0;
              final fahrenheit = (celsius * 9 / 5) + 32;
              final kelvin = celsius + 273.15;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hasil Konversi'),
                  content: Text('Fahrenheit: ${fahrenheit.toStringAsFixed(2)}\nKelvin: ${kelvin.toStringAsFixed(2)}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Konversi'),
          ),
        ],
      ),
    );
  }
}

// Widget untuk konversi mata uang
class CurrencyConversion extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final double exchangeRate = 15000; // Contoh nilai tukar IDR ke USD

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Masukkan jumlah dalam IDR'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0.0;
              final usd = amount / exchangeRate;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hasil Konversi'),
                  content: Text('USD: ${usd.toStringAsFixed(2)}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Konversi'),
          ),
        ],
      ),
    );
  }
}

// Widget untuk konversi berat
class WeightConversion extends StatelessWidget {
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Masukkan berat dalam Kilogram'),
          ),
          ElevatedButton(
            onPressed: () {
              final kg = double.tryParse(weightController.text) ?? 0.0;
              final grams = kg * 1000;
              final pounds = kg * 2.20462;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hasil Konversi'),
                  content: Text('Gram: ${grams.toStringAsFixed(2)}\nPounds: ${pounds.toStringAsFixed(2)}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Konversi'),
          ),
        ],
      ),
    );
  }
}
