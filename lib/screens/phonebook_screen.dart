import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'contact_model.dart';

class PhoneBookScreen extends StatefulWidget {
  @override
  _PhoneBookScreenState createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Contact> contacts = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    final fetchedContacts = await dbHelper.getContacts();
    setState(() {
      contacts = fetchedContacts;
    });
  }

  Future<void> _addContact() async {
    final String name = nameController.text.trim();
    final String phone = phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      await dbHelper.insertContact(Contact(name: name, phone: phone));
      nameController.clear();
      phoneController.clear();
      _fetchContacts();
    }
  }

  Future<void> _deleteContact(int id) async {
    await dbHelper.deleteContact(id);
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku Telepon'),
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
              children: [
                // Nama Input Field with Box Border
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Nomor Telepon Input Field with Box Border
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 10),

                // Add Contact Button
                ElevatedButton(
                  onPressed: _addContact,
                  child: Text('Tambah Kontak'),
                ),

                // Display contacts
                Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.phone),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteContact(contact.id!),
                          ),
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
    );
  }
}
