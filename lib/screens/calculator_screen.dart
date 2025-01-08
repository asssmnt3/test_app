import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0"; // Menampilkan hasil di layar
  String _output = "0"; // Output sementara
  double num1 = 0; // Menyimpan angka pertama
  double num2 = 0; // Menyimpan angka kedua
  String operand = ""; // Menyimpan operator
  bool isOperatorPressed = false; // Mengecek apakah operator sudah dipilih

  // Fungsi untuk format output
  String _formatOutput(String result) {
    double value = double.parse(result);
    if (value == value.toInt()) {
      // Jika bilangan bulat, tampilkan tanpa desimal
      return value.toInt().toString();
    }
    return value.toString(); // Jika tidak, tetap tampilkan desimal
  }

  // Fungsi untuk meng-handle input tombol
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        // Reset kalkulator
        _output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
        isOperatorPressed = false;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        // Jika operator dipilih
        if (isOperatorPressed) {
          // Jika operator sudah ada, lakukan operasi sebelumnya dengan angka terakhir
          num2 = double.parse(output);
          _output = _formatOutput(_calculateResult().toString());
          num1 = double.parse(_output); // Set hasil sebagai angka pertama
        } else {
          num1 = double.parse(output); // Set angka pertama
        }
        operand = buttonText;
        isOperatorPressed = true;
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output = _output + buttonText;
        }
      } else if (buttonText == "=") {
        // Ketika tombol "=" ditekan, hasilnya dihitung
        num2 = double.parse(output);
        _output = _formatOutput(_calculateResult().toString());
        operand = "";
        isOperatorPressed = false;
      } else {
        // Menambah angka atau reset output
        if (_output == "0" || isOperatorPressed) {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
        isOperatorPressed = false; // Reset status operator setelah memasukkan angka
      }

      output = _formatOutput(_output);
    });
  }

  // Fungsi untuk melakukan operasi perhitungan
  double _calculateResult() {
    if (operand == "+") {
      return num1 + num2;
    } else if (operand == "-") {
      return num1 - num2;
    } else if (operand == "*") {
      return num1 * num2;
    } else if (operand == "/") {
      return num1 / num2;
    }
    return 0;
  }

  // Fungsi untuk membuat tombol kalkulator
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          padding: EdgeInsets.all(24),
          side: BorderSide(width: 1, color: Colors.black12),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cream.jpg'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Display output
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  child: Text(
                    output, // Menampilkan angka dan operator
                    style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Divider line
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                // Buttons layout
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                          buildButton("/"),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("4"),
                          buildButton("5"),
                          buildButton("6"),
                          buildButton("*"),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                          buildButton("-"),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("."),
                          buildButton("0"),
                          buildButton("00"),
                          buildButton("+"),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("CLEAR"),
                          buildButton("="),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
