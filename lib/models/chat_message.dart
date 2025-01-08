import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // Convert from map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
