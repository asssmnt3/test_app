import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _firestore.collection('messages').add({
        'sender': 'User', // Ganti dengan user login
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print('No data available');
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                print('Fetched ${messages.length} messages');

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index];
                    print('Message: ${messageData.data()}');

                    // Validasi field agar aman dari nilai null
                    final sender = messageData['sender'] ?? 'Unknown';
                    final message = messageData['message'] ?? 'Message deleted';
                    final timestamp = messageData['timestamp'] != null
                        ? (messageData['timestamp'] as Timestamp).toDate()
                        : DateTime.now();

                    return ListTile(
                      title: Text(sender),
                      subtitle: Text(message),
                      trailing: Text(
                        '${timestamp.hour}:${timestamp.minute}', // Format jam:menit
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
