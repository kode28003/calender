import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/message.dart';

final messageSnapshotStreamProvider =
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  Query<Map<String, dynamic>> query = MessageFirestore.ref;
  final startTime = DateTime.now().subtract(const Duration(minutes: 1));
  query = query.where('id', isGreaterThan: Timestamp.fromDate(startTime));
  return query.snapshots();
});

final _messageProvider = Provider.autoDispose<Iterable<MessageCase>>((ref) {
  final asyncSnapshot = ref.watch(messageSnapshotStreamProvider);
  return asyncSnapshot.when(
      data: (snapshot) {
        final message = snapshot.docs.map((doc) {
          final data = doc.data();
          return MessageCase(
            name: data['name'],
            datetime: data['datetime'],
            message: data['message'],
          );
        });
        //addSetMessage(message);
        return message;
      },
      loading: () => [],
      error: (error, stackTrace) => []);
});

final messageProvider = Provider.autoDispose<Iterable<MessageCase>>((ref) {
  final messageDate=ref.watch(_messageProvider);
  //adding(messageDate); //こいつが入ると自動的に空白のリストが入ってしまう
  return messageDate;
}); // これをwatchしてListに入れる！


class MessageFirestore {
  static final ref =
      FirebaseFirestore.instance.collection('SDGs_Calendar/v0/sns');

  static Future<String> addMessageList(MessageCase messageCase) async {
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': messageCase.name,
      'datetime': messageCase.datetime,
      'message': messageCase.message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
    return docRef.id;
  }

  static Future addLastList(List<ChatMessageModel> dummyList)async{
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': dummyList[dummyList.length-1].name,
      'datetime': dummyList[dummyList.length-1].datetime,
      'message': dummyList[dummyList.length-1].message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
  }

  static Future addmessageListToBase(List<MessageCase> messageList)async{
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': messageList[messageList.length-1].name,
      'datetime': messageList[messageList.length-1].datetime,
      'message': messageList[messageList.length-1].message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
  }

  static Future testFirestore() async {
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'message': today,
    }).then((_) => print('セット完了'));
  }
}
