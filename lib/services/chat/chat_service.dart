import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message

  // recieve message
}
