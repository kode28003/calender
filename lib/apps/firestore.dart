import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Firestore {
  static final ref =
  FirebaseFirestore.instance.collection('SDGs_Calendar/v0/todo');

  static Future<String> add() async {
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'timestamp': today,
      'written': 1,
    }).then((_) => print('Visitor Added, ID : $docRef.id'));
    return docRef.id;
  }
}